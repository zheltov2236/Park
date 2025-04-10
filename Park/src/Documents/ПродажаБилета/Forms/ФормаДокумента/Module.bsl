#Область ОписаниеПеременных 



#КонецОбласти
#Область ОбработчикСобытийФормы

#КонецОбласти
#Область ОбработчикиСобытийЭлементовШапкиФормы
&НаКлиенте
Процедура НоменклатураПриИзменении(Элемент)
    Объект.Цена = ЦенаНоменклатуры(Объект.Номенклатура,Объект.Дата);
    РассчитатьСуммуДокумента();
    
КонецПроцедуры

&НаКлиенте
Процедура ЦенаПриИзменении(Элемент)
    РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура СкидкаПриИзменении(Элемент)
    РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура СуммаДокументаПриИзменении(Элемент)
    Объект.СуммаДокумента = Объект.Цена - Объект.СуммаДокумента;
КонецПроцедуры
#КонецОбласти
#Область ОбработчикиКомандФормы
    
#КонецОбласти
#Область СлужебныеПроцедурыИфункции
&НаКлиенте
Процедура РассчитатьСуммуДокумента()
    Объект.СуммаДокумента = Объект.Цена - Объект.БаллыКСписанию;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЦенаНоменклатуры(Знач Параметры,Знач Период)
    Запрос = Новый Запрос;
    Запрос.Текст = "ВЫБРАТЬ
    |    ЦеныНоменклатурыСрезПоследних.Цена
    |ИЗ
    |    РегистрСведений.ЦеныНоменклатуры.СрезПоследних(&Период, Номенклатура = &Номенклатура) КАК
    |        ЦеныНоменклатурыСрезПоследних";
    Запрос.УстановитьПараметр("Период",Период);
    Запрос.УстановитьПараметр("Номенклатура",Параметры);
    Выборка = Запрос.Выполнить().Выбрать();
    Если Выборка.Следующий() Тогда
        Возврат Выборка.Цена;
    КонецЕсли;
    
    Возврат 0;
КонецФункции

#КонецОбласти




