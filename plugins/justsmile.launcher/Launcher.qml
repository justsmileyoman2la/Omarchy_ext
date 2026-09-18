import QtQuick
import Quickshell
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "justsmile.launcher"

  readonly property var apps: settings.apps || [
    { "name": "Browser", "command": "chromium", "icon": "󰖟" },
    { "name": "Terminal", "command": "foot", "icon": "󰆏" },
    { "name": "Files", "command": "nautilus", "icon": "󰉋" }
  ]

  readonly property bool barHovered: bar ? bar.barHovered : false
  readonly property bool centerRevealHeld: bar ? bar.centerSectionRevealHeld : false
  readonly property bool revealed: barHovered || centerRevealHeld

  visible: true
  opacity: revealed ? 1 : 0
  Behavior on opacity { NumberAnimation { duration: 150 } }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  readonly property bool opened: panelLoader.item ? panelLoader.item.opened === true : false

  function open() {
    if (panelLoader.item) panelLoader.item.open()
  }

  function close() {
    if (panelLoader.item) panelLoader.item.close()
  }

  function togglePanel() {
    if (panelLoader.item) panelLoader.item.toggle()
  }

  function injectPanel() {
    var target = panelLoader.item
    if (!target) return
    if ("bar" in target) target.bar = root.bar
    if ("settings" in target) target.settings = root.settings
    if ("anchorItem" in target) target.anchorItem = button
    if ("hostWidget" in target) target.hostWidget = root
  }

  onBarChanged: injectPanel()
  onSettingsChanged: injectPanel()

  Loader {
    id: panelLoader
    active: true
    source: Qt.resolvedUrl("Panel.qml")
    visible: false
    onLoaded: {
      root.injectPanel()
      Qt.callLater(root.injectPanel)
    }
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
        root.bar.run("xdg-open ~/.config/omarchy/plugins/justsmile.launcher/manifest.json")
      } else {
        root.togglePanel()
      }
    }
  }
}
