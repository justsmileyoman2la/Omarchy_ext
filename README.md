# Omarchy_ext

Моя конфигурация [Omarchy](https://omarchy.org/) — кастомные плагины, layout бара, хуки и расширения.

## Панель (Bar Layout)

```
Left:    Workspaces │ CAVA │ Active Window
Center:  Indicators │ Clock │ Launcher │ Weather │ System Update
Right:   Countdown │ Tray │ WireGuard │ OmaStats │ Agents │ Network │ Keyboard │ Audio │ Power │ Menu
```

## Кастомные плагины

| Плагин | Описание |
|--------|----------|
| `justsmile.launcher` | Лончер приложений — иконка в баре, появляется при hover, открывает панель с apps |
| `justsmile.clock` | Кастомные часы с календарём (dddd, d MMMM HH:mm) |
| `justsmile.weather` | Виджет погоды (metric) |
| `justsmile.audio` | Управление звуком |
| `justsmile.active-window` | Заголовок активного окна |
| `justsmile.workspaces` | Индикатор рабочих столов |
| `justsmile.tray` | Системный трей |
| `justsmile.countdown` | Таймер обратного отсчёта |

## Сторонние плагины

Устанавливаются отдельно (не включены в репо):

- [crmne.omastats](https://github.com/crmne/omastats) — мониторинг системы (CPU, RAM, диски, батарея)
- [wmfeht.border-fx](https://github.com/wmfeht/border-fx) — эффекты границ окон
- [remco.wireguard](https://github.com/remco-wireguard/omarchy-wireguard) — WireGuard VPN (цвета инвертированы: серый = работает, красный = выключен)
- [my.cava](https://github.com/itdir/cava-omarchy) — аудио визуализатор
- [io.github.ol4vr.languages](https://github.com/ol4vr/languages) — переключатель раскладки клавиатуры

## Структура

```
~/.config/omarchy/
├── shell.json              # Layout бара и виджетов
├── shell.toml              # Общие настройки shell
├── extensions/
│   └── omarchy-menu.jsonc  # Кастомное меню
├── plugins/
│   ├── justsmile.*         # Кастомные плагины
│   └── ...                 # Сторонние плагины (gitignore)
├── hooks/                  # Автоматизация
├── branding/               # about.txt, screensaver
├── defaults/               # Дефолтный агент
└── themed/                 # Шаблоны терминалов
```

## Установка

```bash
# Клонировать в ~/.config/omarchy
git clone https://github.com/justsmileyoman2la/Omarchy_ext.git ~/.config/omarchy

# Перезапустить shell
omarchy restart shell
```

## Лончер

Иконка 󰀻 скрыта по умолчанию, появляется при наведении мыши на бар.

- **Левый клик** — открыть панель с приложениями
- **Правый клик** — редактировать manifest.json

Для изменения списка приложений отредактируй `apps` в:
- `plugins/justsmile.launcher/Launcher.qml`
- `plugins/justsmile.launcher/Panel.qml`

## Настройки

- **Idle**: lock 300s, screensaver 150s
- **Bar**: position top, transparent
- **Позиция панели**: верхняя, прозрачная
