# FigureBuilding

**FigureBuilding** это немного переработанное решение твоего домашнего задания о построении пересеченных диагоналей и периметров прямоугольника и ромба.
Вместо расположения вручную каждого элемента на форме и установкой вручную его свойств, тут использованы циклы.

#### Краткое описание заложенного принципа

- Задаются глобальные константы `K` - размерность массива `[K, K]` и `lblCaption` - надпись, которой будет строится массив.
- При создании формы, создается надпись в невидимой части (ниже высоты панели). Эта надпись нужна будет, чтобы определить ее размеры (почему-то определяются неправильно!) и стартовые координаты для отображения. Размеры я решил не заносить в переменную, а возвращать их каждый раз при обращении к соответствующим функциям `GetTestLabelHeight()` и `GetTestLabelWidth()`.
- Каждый из трех checkbox привязан по событию `onClick` к своей отдельной процедуре. В начале этих процедур происходит обращение к процедуре удаления всех `TLabel`, кроме `lbl[0, 0]`. Также, удаление всех `TLabel` продублировано на отдельную кнопку на форме.
- За создание `TLabel` отвечает функция `CreateLbl()`, которая в качестве аргументов получает координаты Top и Left.

Хочу обратить твое внимание на двумерный массив `lbl` - это массив `TLabel`! Т.е. массив, каждый элементик которого это объект `TLabel`.

В качестве целочисленных типов переменных я использовал не `integer`, а `byte` и `word`. Я не спросил, знакомы ли они тебе. Вот [здесь](https://www.freepascal.org/docs-html/ref/refsu4.html#x26-26003r2) отличная маленькая табличка с их описанием. 

Уверен, ты найдешь что улучшить!
**Успехов!**
