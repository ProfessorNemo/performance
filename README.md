$ rails _6.1.6.1_ new poster -M --skip-action-mailbox --skip-action-text --skip-active-job --skip-active-storage -C -S -J -T --api -d postgresql

$ rails g model Event title schedule:daterange

$ rails db:migrate

e = Event.new(title: "M & M", schedule: Date.parse("2021-12-06")..Date.parse("2021-12-12"))
e2 = Event.new(title: "Figaro", schedule: Date.parse("2021-12-14")..Date.parse("2021-12-18"))
e.save
e2.save

e2.destroy

Добавим ограничение ввиду возможного пересечения расписания спектаклей,
чтобы в БД не попали кривые данные
см. https://www.postgresql.org/docs/9.6/rangetypes.html
(8.17.10. Constraints on Ranges)

$ rails g migration AddScheduleOvelappingConstraint


добавить в application.rb:
config.active_record.schema_format = :sql

затем: rails db:migrate
и в директории db появится файлик structure.sql (для удобства)


e2 = Event.new(title: "Figaro")
=> #<Event:0x000055cf8c576230 id: nil, title: "Figaro", schedule: nil, created_at: nil, updated_at: nil, starts_at: nil, ends_at: nil>
[2] pry(main)> e2.starts_at = "2021-12-19"
=> "2021-12-19"
[3] pry(main)> e2.ends_at = "2021-12-25"
=> "2021-12-25"
[4] pry(main)> e2
=> #<Event:0x000055cf8c576230 id: nil, title: "Figaro", schedule: nil, created_at: nil, updated_at: nil, starts_at: Sun, 19 Dec 2021, ends_at: Sat, 25 Dec 2021>
[5] pry(main)> e2.save
  TRANSACTION (0.4ms)  BEGIN
  Event Create (2.3ms)  INSERT INTO "events" ("title", "schedule", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["title", "Figaro"], ["schedule", "[2021-12-19,2021-12-25]"], ["created_at", "2022-09-18 00:43:21.674820"], ["updated_at", "2022-09-18 00:43:21.674820"]]
  TRANSACTION (4.4ms)  COMMIT
=> true
[6] pry(main)> e2.reload

pry(main)> e3 = Event.new(title: "Ivan Susanin")
=> #<Event:0x00007fbf8818edf0 id: nil, title: "Ivan Susanin", schedule: nil, created_at: nil, updated_at: nil, starts_at: nil, ends_at: nil>
[8] pry(main)> e3.starts_at = "2021-12-30"
=> "2021-12-30"
[9] pry(main)> e3.ends_at = "2021-12-30"
=> "2021-12-30"
[10] pry(main)> e3.save
  TRANSACTION (0.1ms)  BEGIN
  Event Create (0.3ms)  INSERT INTO "events" ("title", "schedule", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["title", "Ivan Susanin"], ["schedule", "[2021-12-30,2021-12-30]"], ["created_at", "2022-09-18 00:45:30.143517"], ["updated_at", "2022-09-18 00:45:30.143517"]]
  TRANSACTION (3.9ms)  COMMIT
=> true



***(как подключить tailwinds)
https://v1.tailwindcss.com/docs/width#app

В шаблон layout перед всеми стилями (перед stylesheet_link_tag)
<link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
или лучше так даже:
$ wget https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css
$ mv tailwind.min.css app/assets/stylesheets
затем в application.css:
*= require "tailwind.min"
.....................
*= require_self - подключить все, что будет ниже этой строчки