#include "debug_interceptor.hpp"


QSharedPointer<Debug_Interceptor> Debug_Interceptor::getInstance(){
    static QSharedPointer<Debug_Interceptor> instance{new Debug_Interceptor(true, true, QCoreApplication::applicationFilePath() + "Logs.txt")};
    return instance;
}

Debug_Interceptor::Debug_Interceptor(bool displayToConsole, bool saveToFile, QString logsPath, QObject *parent) :
QObject{parent}, displayToConsole(displayToConsole), saveToFile(saveToFile){

    logFile = QSharedPointer<QFile>(new QFile(logsPath));

    if (logFile->open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text)){

        QTextStream out(logFile.data());
        QString currentDateStr { QDateTime::currentDateTime().toString(Qt::ISODate) };

        currentDateStr.replace('T', ' ');
        out << "[Execution " + currentDateStr + "]" + QString(2, '\n');

        qInstallMessageHandler(&Debug_Interceptor::myMessageOutputHandler);
    }

    else{
        qCritical() << "Failed to open log file!";
    }
}

Debug_Interceptor::~Debug_Interceptor(){
    if(logFile && logFile->isOpen()) logFile->close();
}


void Debug_Interceptor::myMessageOutputHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg) {
    QSharedPointer<Debug_Interceptor>instance{ getInstance() };
    if (instance) instance->myMessageOutput(type, context, msg);
}

void Debug_Interceptor::myMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QByteArray localMsg{ msg.toLocal8Bit() };

    QString currentDateStr{ QDateTime::currentDateTime().toString(Qt::ISODate) }, msgType{};

    currentDateStr.replace('T', ' ');

    const char* file{ context.file ? context.file : "" };
    const char* function{ context.function ? context.function : "" };

    QTextStream out(logFile.data());

    switch(type) {

        case QtDebugMsg:
            msgType = "Debug";
            break;
        case QtInfoMsg:
            msgType = "Info";
            break;
        case QtWarningMsg:
            msgType = "Warning";
            break;
        case QtCriticalMsg:
            msgType = "Critical";
            break;
        case QtFatalMsg:
            msgType = "Fatal";
            break;
    }

    QString contextFile = context.file;
    contextFile = contextFile.right(contextFile.length() - contextFile.lastIndexOf('/') - 1);

    if(saveToFile){
        out << "[" + msgType + " " + currentDateStr + "]: " << localMsg.constData() << "\n" << contextFile << ":" << context.line << ", " << context.function << QString(2, '\n');
    }

    if(displayToConsole){
        fprintf(stderr, "\n[%s]: %s (%s:%u, %s)\n", msgType.toUtf8().constData(), localMsg.constData(), file, context.line, function);
    }
}

