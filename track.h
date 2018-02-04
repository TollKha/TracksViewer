#ifndef TRACK_H
#define TRACK_H

#include <QObject>

class Track : public QObject
{
    Q_OBJECT
public:
    Q_ENUMS(TrackType)
    enum TrackType {
        USB,
        BTA
    };
};

#endif // TRACK_H
