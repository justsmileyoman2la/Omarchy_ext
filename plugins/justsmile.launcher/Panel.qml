import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

Panel {
  id: root
  moduleName: "justsmile.launcher"
  ipcTarget: "justsmile.launcher"
  manageIpc: false

  readonly property color foreground: bar ? bar.foreground : Color.foreground
  readonly property string fontFamily: bar ? bar.fontFamily : Style.font.family

  property var apps: settings.apps || [
    { "name": "Browser", "command": "chromium", "icon": "󰖟" },
    { "name": "Terminal", "command": "foot", "icon": "󰆏" },
    { "name": "Files", "command": "nautilus", "icon": "󰉋" }
  ]

  visible: true
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  function launchApp(command) {
    if (root.bar) root.bar.run(command)
    root.close()
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "󰀻"
    slotSize: Style.bar.statusSlot
    tooltipText: "Applications"
    onPressed: function(buttonCode) {
      if (buttonCode === Qt.RightButton) {
        root.launchApp("xdg-open ~/.config/omarchy/plugins/justsmile.launcher/manifest.json")
      } else {
        root.toggle()
      }
    }
  }

  KeyboardPanel {
    id: panel
    anchorItem: button
    owner: root
    bar: root.bar
    open: root.opened
    focusTarget: keyCatcher
    contentWidth: panel.fittedContentWidth(Style.space(300))
    contentHeight: panel.fittedContentHeight(grid.implicitHeight + Style.space(24))

    PanelKeyCatcher {
      id: keyCatcher
      anchors.fill: parent

      onMoveRequested: function(dx, dy) {}
      onActivateRequested: root.close()
      onCloseRequested: root.close()

      Grid {
        id: grid
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Style.space(12)
        columns: 4
        spacing: Style.space(8)

        Repeater {
          model: root.apps

          Item {
            required property var modelData
            required property int index

            width: Style.space(60)
            height: Style.space(60)

            Rectangle {
              anchors.fill: parent
              radius: Style.cornerRadius
              color: mouseArea.containsMouse ? Qt.rgba(foreground.r, foreground.g, foreground.b, 0.15) : "transparent"

              Column {
                anchors.centerIn: parent
                spacing: Style.space(4)

                Text {
                  text: modelData.icon || "󰀻"
                  color: root.foreground
                  font.family: root.fontFamily
                  font.pixelSize: Style.font.display
                  anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                  text: modelData.name || ""
                  color: root.foreground
                  font.family: root.fontFamily
                  font.pixelSize: Style.font.caption
                  anchors.horizontalCenter: parent.horizontalCenter
                  elide: Text.ElideRight
                  width: Style.space(56)
                  horizontalAlignment: Text.AlignHCenter
                }
              }
            }

            MouseArea {
              id: mouseArea
              anchors.fill: parent
              hoverEnabled: true
              onClicked: root.launchApp(modelData.command)
            }
          }
        }
      }
    }
  }

  IpcHandler {
    target: root.ipcTarget
    function open(): void { root.open() }
    function close(): void { root.close() }
    function show(): void { root.open() }
    function hide(): void { root.close() }
    function toggle(): void { root.toggle() }
  }
}
