# Performance (API)

###### Ruby: `3.0.3` Rails: `6.1.6.1`

###### Команда для создания приложения
```
###### rails _6.1.6.1_ new poster -M --skip-action-mailbox --skip-action-text --skip-active-job --skip-active-storage -C -S -J -T --api -d postgresql
```

### Описание

Проект создан в рамках одного тестового задания. Требования предъявленные к проекту описаны ниже.

### Требования к проекту:

Мы делаем сайт для, небольшого, провинциального театра. Город N, в котором находится театр маленький, публики не много, поэтому спектакли проводятся строго один раз в день, в 19:00.

Нам прежде всего предстоит реализовать афишу. У нас есть администратор театра, Оксана Григорьевна, уважаемая женщина. Она и будет вносить расписание спектаклей.

Спектакль характеризуется свойствами:

    Название
    Дата начала (19-02-2023)
    Дата окончания (21-03-2023)

У нас методы create, index, delete.

При добавлении нового спектакля, если у нас есть уже спектакль на эти даты - мы выводим ошибку.

Систему авторизации писать не нужно, мы просто закроем доступ к методам create\delete средствами nginx в дальнейшем.

Web интерфейс только при большом желании, достаточно методов API.

Тесты тоже очень приветствуются.

В качестве БД рекомендую посмотреть Postgresql и нестандартные типы данных.


### Клонирование репозитория
```
git clone git@github.com:ProfessorNemo/performance.git
```

### Установка библиотек
```
bundle
```

### Подготовка и заполнение базы данных тестовым контентом:
```
make initially
```

### Запуск сервера
```
make web
```

### Тесты
```
make rspec
```

### Документация API

Примеры запросов доступны по адресу http://localhost:3000/docs (сервер должен быть запущен)





