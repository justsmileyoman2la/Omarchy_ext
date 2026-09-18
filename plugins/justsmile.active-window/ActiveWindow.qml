import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy.active-window"

  readonly property var toplevel: ToplevelManager.activeToplevel
  readonly property string title: toplevel ? (toplevel.title || toplevel.appId || "") : ""
  readonly property int maxLabelWidth: Number(setting("maxWidth", 280))
  readonly property bool isOverflow: labelText.implicitWidth > maxLabelWidth

  visible: title !== "" && !vertical
  implicitWidth: visible ? maxLabelWidth + Style.spacing.controlPaddingX * 2 : 0
  implicitHeight: barSize

  Item {
    anchors.fill: parent
    anchors.leftMargin: Style.space(8)
    anchors.rightMargin: Style.space(8)
    clip: true

    Text {
      id: labelText
      textFormat: Text.PlainText
      anchors.verticalCenter: parent.verticalCenter
      x: 0
      text: root.title
      color: root.bar ? root.bar.barForeground : Color.foreground
      font.family: root.bar ? root.bar.fontFamily : Style.font.family
      font.pixelSize: Style.font.body
      opacity: 0.85
    }

    SequentialAnimation {
      id: scrollAnimation
      running: root.isOverflow
      loops: Animation.Infinite

      PropertyAction {
        target: labelText
        property: "x"
        value: 0
      }

      PauseAnimation { duration: 1000 }

      NumberAnimation {
        target: labelText
        property: "x"
        from: 0
        to: -(labelText.implicitWidth - root.maxLabelWidth)
        duration: Math.max(2000, (labelText.implicitWidth - root.maxLabelWidth) * 15)
        easing.type: Easing.Linear
      }

      PauseAnimation { duration: 1000 }

      NumberAnimation {
        target: labelText
        property: "x"
        from: -(labelText.implicitWidth - root.maxLabelWidth)
        to: 0
        duration: Math.max(2000, (labelText.implicitWidth - root.maxLabelWidth) * 15)
        easing.type: Easing.Linear
      }

      PauseAnimation { duration: 1000 }
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor

    onClicked: function(mouse) {
      if (!root.toplevel) return
      if (mouse.button === Qt.MiddleButton) {
        root.toplevel.close()
      } else if (mouse.button === Qt.RightButton) {
        root.toplevel.close()
      } else {
        root.toplevel.activate()
      }
    }
    onEntered: if (root.bar) root.bar.showTooltip(root, root.title)
    onExited: if (root.bar) root.bar.hideTooltip(root)
  }
}
