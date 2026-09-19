import QtQuick
import Quickshell
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "justsmile.countdown"

  property date targetDate: new Date(2027, 6, 20)
  property int daysLeft: 0

  readonly property string displayText: {
    if (daysLeft > 0) return daysLeft + " дней"
    if (daysLeft === 0) return "СЕГОДНЯ!"
    return "Прошло"
  }

  function updateCountdown() {
    var now = new Date()
    var diff = targetDate.getTime() - now.getTime()
    daysLeft = Math.ceil(diff / (1000 * 60 * 60 * 24))
  }

  Component.onCompleted: updateCountdown()

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  Timer {
    interval: 3600000
    running: true
    repeat: true
    onTriggered: root.updateCountdown()
  }

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "\uf017 " + root.displayText
    fontSize: Style.font.caption
    horizontalMargin: 6
    tooltipText: "Обратный отсчет до 20.07.2027"
  }
}
