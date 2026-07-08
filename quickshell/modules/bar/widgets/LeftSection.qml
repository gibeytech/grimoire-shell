import QtQuick

import "." as Widgets

Item {
    implicitWidth: workspaceWidget.implicitWidth
    implicitHeight: workspaceWidget.implicitHeight

    Widgets.WorkspaceWidget {
        id: workspaceWidget
    }
}
