<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Validation Language Lines
    |--------------------------------------------------------------------------
    |
    | following language lines contain default error messages used by
    | validator class. Some of these rules have multiple versions such
    | as size rules. Feel free to tweak each of these messages here.
    |
    */

    'accepted' => 'Атрибут :attribute должен быть принят.',
    'active_url' => ':attribute не является валидным url.',
    'after' => ':attribute должен быть двтой после :date.',
    'after_or_equal' => ':attribute должен быть датой после и равной :date.',
    'alpha' => ':attribute должен содержать только буквы.',
    'alpha_dash' => ':attribute может содержать только буквы, числа, тире и подчеркивания.',
    'alpha_num' => ':attribute может содержать только буквы и числа.',
    'array' => ':attribute должен быть массивом.',
    'before' => ':attribute должен быть датой до :date.',
    'before_or_equal' => ':attribute должен быть датой до или равной :date.',
    'between' => [
        'numeric' => ':attribute должен быть между :min и :max.',
        'file' => ':attribute должен быть между :min и :max килобайт.',
        'string' => ':attribute должен быть между :min и :max символов.',
        'array' => ':attribute должен быть между :min и :max элементов.',
    ],
    'boolean' => 'Поле :attribute должно быть истинно или ложно.',
    'confirmed' => ':attribute подтверждение не совпадает.',
    'date' => ':attribute не корректная дата.',
    'date_equals' => ':attribute должно быть датой соответсвующей :date.',
    'date_format' => ':attribute не совпадает формат :format.',
    'different' => ':attribute и :other должны быть отличны.',
    'digits' => ':attribute должен содержать :digits цифры.',
    'digits_between' => ':attribute должен быть между :min и :max digits.',
    'dimensions' => ':attribute некорректное разрешение.',
    'distinct' => ':attribute дублирующее значение.',
    'email' => ':attribute должен быть валидным email адресом.',
    'exists' => 'Выбранный :attribute некорректен.',
    'file' => ':attribute должен быть файлом.',
    'filled' => ':attribute должно быть заполнено.',
    'gt' => [
        'numeric' => ':attribute должен быть больше :value.',
        'file' => ':attribute должен быть больше :value килобайт.',
        'string' => ':attribute должен быть больше :value символов.',
        'array' => ':attribute должен быть больше :value элементов.',
    ],
    'gte' => [
        'numeric' => ':attribute должен быть больше или равен :value.',
        'file' => ':attribute должен быть больше или равен :value килобайт.',
        'string' => ':attribute должен быть больше или равен :value символов.',
        'array' => ':attribute должен содержать :value элементов или больше.',
    ],
    'image' => ':attribute должен быть изображением.',
    'in' => 'Выбранный :attribute неверен.',
    'in_array' => ':attribute не существует в :other.',
    'integer' => ':attribute должен быть целым числом.',
    'ip' => ':attribute must be a valid IP address.',
    'ipv4' => ':attribute must be a valid IPv4 address.',
    'ipv6' => ':attribute must be a valid IPv6 address.',
    'json' => ':attribute must be a valid JSON string.',
    'lt' => [
        'numeric' => ':attribute должен быьт меньше, чем :value.',
        'file' => ':attribute должен быьт меньше, чем :value килобайт.',
        'string' => ':attribute должен быьт меньше, чем :value символов.',
        'array' => ':attribute должен быьт меньше, чем :value элементов.',
    ],
    'lte' => [
        'numeric' => ':attribute должен быьт меньше или равен :value.',
        'file' => ':attribute должен быьт меньше или равен :value килобайт.',
        'string' => ':attribute должен быьт меньше или равен :value символов.',
        'array' => ':attribute не может включать больше :value элементов.',
    ],
    'max' => [
        'numeric' => ':attribute не может быть больше :max.',
        'file' => ':attribute не может быть больше :max килобайт.',
        'string' => ':attribute не может быть больше :max символов.',
        'array' => ':attribute не может быть включать больше :max элементов.',
    ],
    'mimes' => ':attribute должен быть типа: :values.',
    'mimetypes' => ':attribute должен быть файл типа: :values.',
    'min' => [
        'numeric' => ':attribute должен быть минимум :min.',
        'file' => ':attribute должен быть минимум :min килобайт.',
        'string' => ':attribute должен быть минимум :min символов.',
        'array' => ':attribute должен включать как минимум :min элементов.',
    ],
    'not_in' => 'Выбранный :attribute некорректен.',
    'not_regex' => ':attribute формат некорректен.',
    'numeric' => ':attribute должен быть числом.',
    'present' => ':attribute поле должно быть.',
    'regex' => ':attribute формат некорректен.',
    'required' => ':attribute необходимое поле.',
    'required_if' => ':attribute необходимое поле, когда :other :value.',
    'required_unless' => ':attribute необходимое поле unless :other is in :values.',
    'required_with' => ':attribute необходимое поле when :values is present.',
    'required_with_all' => ':attribute необходимое поле when :values are present.',
    'required_without' => ':attribute необходимое поле when :values is not present.',
    'required_without_all' => ':attribute необходимое поле when none of :values are present.',
    'same' => ':attribute и :other должны совпадать.',
    'size' => [
        'numeric' => ':attribute должен быть :size.',
        'file' => ':attribute должен быть :size килобайт.',
        'string' => ':attribute должен быть :size символов.',
        'array' => ':attribute должен содержать :size элементов.',
    ],
    'starts_with' => ':attribute должен начинаться с: :values',
    'string' => ':attribute должна быть строка.',
    'timezone' => ':attribute должна быть валидная зона.',
    'unique' => ':attribute уже используется.',
    'uploaded' => ':attribute ошибка загрузки.',
    'url' => ':attribute формат неверен.',
    'uuid' => ':attribute должен быть авлидным UUID.',

    /*
    |--------------------------------------------------------------------------
    | Custom Validation Language Lines
    |--------------------------------------------------------------------------
    |
    | Here you may specify custom validation messages for attributes using the
    | convention "attribute.rule" to name lines. This makes it quick to
    | specify a specific custom language line for a given attribute rule.
    |
    */

    'custom' => [
        'attribute-name' => [
            'rule-name' => 'custom-message',
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Custom Validation Attributes
    |--------------------------------------------------------------------------
    |
    | following language lines are used to swap our attribute placeholder
    | with something more reader friendly such as "E-Mail Address" instead
    | of "email". This simply helps us make our message more expressive.
    |
    */

    'attributes' => [],

];
