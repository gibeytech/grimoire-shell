import QtQuick

import "." as Widgets

Item {
    implicitWidth: statusWidget.implicitWidth
    implicitHeight: statusWidget.implicitHeight

    Widgets.StatusWidget {
        id: statusWidget
    }
}
