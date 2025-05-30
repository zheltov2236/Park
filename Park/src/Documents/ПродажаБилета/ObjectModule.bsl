#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
	
#Область ПрограммныйИнтерфейс



#КонецОбласти

#Область ОбработчикиСобытий
Процедура ОбработкаПроведения(Отказ,Режим)

    
	СвойствоНоменклатуры = СвойствоНоменклатуры(Номенклатура);
	// регистр АктивныеПосещения
	Движения.АктивныеПосещения.Записывать = Истина;
	Движение = Движения.АктивныеПосещения.Добавить();
	Движение.Период = Дата;
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Основание = Ссылка;
	Движение.ВидАттракциона = СвойствоНоменклатуры.ВидАттракциона;
	Движение.КоличествоПосещений = СвойствоНоменклатуры.КоличествоПосещений;

	// регистр Продажи
	Движения.Продажи.Записывать = Истина;
	Движение = Движения.Продажи.Добавить();
	Движение.Период = Дата;
	Движение.Клиент = Клиент;
	Движение.ВидАттракцион = СвойствоНоменклатуры.ВидАттракциона;
	Движение.Сумма = СуммаДокумента;

	
КонецПроцедуры



Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
    
    МаксимальнаяДоля = Константы.МаксимальнаяДоляОплатыБаллами.Получить();
    Если БаллыКСписанию <> 0 Тогда
         Если БаллыКСписанию > Цена Тогда
             Сообщение = Новый СообщениеПользователю();
                          Сообщение.Текст = "Списываемые баллы не должны превышать цену билета";
                          Сообщение.УстановитьДанные(ЭтотОбъект);
                          Сообщение.Поле  = "БаллыКСписанию";
                          Сообщение.Сообщить();
         КонецЕсли;
        Доля = БаллыКСписанию / Цена * 100;
        Если Доля > МаксимальнаяДоля Тогда
            Отказ = Истина;
            Сообщение = Новый СообщениеПользователю();
                         Сообщение.Текст = СтрШаблон("Баллы больше допусти скидки(%1%%)",МаксимальнаяДоля);
                         Сообщение.УстановитьДанные(ЭтотОбъект);
                         Сообщение.Поле  = "БаллыКСписанию";
                         Сообщение.Сообщить();
        КонецЕсли;
    КонецЕсли;
    
КонецПроцедуры
#КонецОбласти

#Область СлужебныйПрограммыйИнтерфейс
	
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Функция СвойствоНоменклатуры(Номенклатура)
	Запрос = Новый Запрос;
	Запрос.Текст ="ВЫБРАТЬ
	|    Номенклатура.ВидАтракциона,
	|    Номенклатура.КоличествоПосещений
	|ИЗ
	|    Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|    Номенклатура.Ссылка = &Ссылка";
	Запрос.УстановитьПараметр("Ссылка",Номенклатура);
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	Результат = Новый Структура;
	Результат.Вставить("ВидАттракциона",Выборка.ВидАтракциона);
	Результат.Вставить("КоличествоПосещений",Выборка.КоличествоПосещений );
	Возврат Результат;
	
КонецФункции



#КонецОбласти
#КонецЕсли
