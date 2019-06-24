<div class="form-row">
    <div class="form-group col">
        <label for="name">Наименование</label>
        <input
            id="name"
            name="name"
            type="text"
            class="form-control"
            placeholder="Наименование"
            value="{{old('name') ?? $item->name ?? ''}}"
        >
    </div>
</div>

<div class="form-row">
    <div class="form-group col">
        <label for="type">Тип</label>
        <select id="type" name="type" class="form-control">
            <option>Выберите тип оповещателя</option>
            ['sound','voice','light']
            <option value="light" @if(old('type') == 'light') selected @endif>
                Световой
            </option>
            <option value="sound" @if(old('type') == 'sound') selected @endif>
                Звуковой
            </option>
            <option value="voice" @if(old('type') == 'voice') selected @endif>
                Речевой
            </option>
        </select>
    </div>
</div>

<div class="form-row">
    <div class="form-group col">
        <label for="power">Мощность</label>
        <input
            id="power"
            name="power"
            type="number"
            class="form-control"
            placeholder="Мощность"
            value="{{old('power') ?? $item->power ?? 0}}"
        >
    </div>
</div>