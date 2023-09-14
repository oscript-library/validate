#Использовать annotations
#Использовать reflector

Перем КонтейнерАннотаций;
Перем ФабрикаВалидаций;

Перем Рефлектор;
Перем КэшВалидаций;

Функция Валидировать(Объект) Экспорт
	
	РезультатВалидации = Новый Массив;
	
	РефлекторОбъекта = Новый РефлекторОбъекта(Объект);
	Свойства = РефлекторОбъекта.ПолучитьТаблицуСвойств(Неопределено, Истина);

	Для Каждого Свойство Из Свойства Цикл
		
		Для Каждого Аннотация Из Свойство.Аннотации Цикл
			
			Если НЕ ФабрикаВалидаций.ЭтоАннотацияВалидации(Аннотация.Имя) Тогда
				Продолжить;
			КонецЕсли;

			ОпределениеАннотации = КонтейнерАннотаций.ПолучитьОпределениеАннотации(Аннотация.Имя);

			Если ОпределениеАннотации = Неопределено Тогда
				Продолжить;
			КонецЕсли;
		
			Ограничение = ОпределениеАннотации.СоздатьОбъектАннотации(Аннотация);
			Валидация = ФабрикаВалидаций.СоздатьОбъектВалидации(Ограничение);
						
			Значение = Рефлектор.ПолучитьСвойство(Объект, Свойство.Имя);
		
			ЗначениеВалидно = Валидация.ЗначениеВалидно(Значение);
			
			Если НЕ ЗначениеВалидно Тогда
				Нарушение = Новый Нарушение(Объект, "Поле", Свойство.Имя, Ограничение.Сообщение(), Ограничение.Код());
				
				РезультатВалидации.Добавить(Нарушение);
			КонецЕсли;

		КонецЦикла;
	
	КонецЦикла;
	
	Возврат РезультатВалидации;
	
КонецФункции

Процедура ПриСозданииОбъекта(пФабрикаВалидаций = Неопределено, пКонтейнерАнноаций = Неопределено)

	Рефлектор = Новый Рефлектор;

	Если пФабрикаВалидаций = Неопределено Тогда
		ФабрикаВалидаций = Новый СтандартнаяФабрикаВалидаций(ЭтотОбъект);
	Иначе
		ФабрикаВалидаций = пФабрикаВалидаций;
	КонецЕсли;

	Если пКонтейнерАнноаций = Неопределено Тогда
		КонтейнерАннотаций = Новый КонтейнерАннотаций;
		КонтейнерАннотаций.ДобавитьАннотацию(Тип("АннотацияВалидно"));
		КонтейнерАннотаций.ДобавитьАннотацию(Тип("АннотацияЗаполнено"));
		КонтейнерАннотаций.ДобавитьАннотацию(Тип("АннотацияИстина"));
		КонтейнерАннотаций.ДобавитьАннотацию(Тип("АннотацияЛожь"));
		КонтейнерАннотаций.ДобавитьАннотацию(Тип("АннотацияМаксимум"));
		КонтейнерАннотаций.ДобавитьАннотацию(Тип("АннотацияМинимум"));
	Иначе
		КонтейнерАннотаций = пКонтейнерАнноаций;
	КонецЕсли;

	КэшВалидаций = Новый Соответствие();

КонецПроцедуры
