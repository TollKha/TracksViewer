#ifndef TRACK_H
#define TRACK_H

#include <QObject>
#include <QDebug>

class Track : public QObject
{
    Q_OBJECT
public:
    Q_ENUMS(TrackType)
    enum TrackType {
        USB,
        BTA
    };

    Q_INVOKABLE void play(const QString& title, const int index) {
        qDebug() << index << "element is playing now";
        qDebug() << "Title: " << title;

        //Call to some third-party code should be here
    }
};

#endif // TRACK_H
