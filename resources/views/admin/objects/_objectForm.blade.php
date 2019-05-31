
            <form action="{{ route('objects.update',['id'=>$item->id]) }}" method="POST" class="col-md-6 offset-md-3">
                @csrf
                <input type="hidden" name="lat" id="lat" value="{{ $item->lat }}">
                <input type="hidden" name="lng" id="lng" value="{{ $item->lng }}">
                <div class="form-row">
                    <div class="form-group col">
                    <label for="name">Название объекта мониторинга</label>
                        <input id="name" name="name" type="text" class="form-control" placeholder="Название объекта мониторинга" value="{{ $item->name }}">
                    </div>
                </div>

                <div class="form-row">      
                    <div class="form-group col">
                        <label for="raion_id">Район</label>
                        <select id="raion_id" name="raion_id" class="form-control">
                            <option>Выберите муниципальное образование</option>
                            @foreach ($raions as $raion)
                            <option data-name="{{ $raion->name }}" data-lat="{{ $raion->lat }}" data-lng="{{ $raion->lng }}" value="{{ $raion->id }}" @if($raion->id == $item->raion_id) selected @endif>{{ $raion->name }}</option>
                            @endforeach
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="address">Адрес объекта мониторинга</label>
                        <input id="address" name="address" type="text" class="form-control" placeholder="Адрес объекта мониторинга" value="{{ $item->address }}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="director_name">ФИО директора</label>
                        <input id="director_name" name="director_name" type="text" class="form-control" placeholder="ФИО директора" value="{{ $item->director_name }}">
                    </div>
                    <div class="form-group col">
                        <label for="director_phone">Телефон директора</label>
                        <input id="director_phone" name="director_phone" type="text" class="form-control" placeholder="Телефон директора"  value="{{ $item->director_phone }}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="contact_name">ФИО ответственного</label>
                        <input id="contact_name" name="contact_name" type="text" class="form-control" placeholder="ФИО ответственного"  value="{{ $item->contact_name }}">
                    </div>
                    <div class="form-group col">
                        <label for="contact_phone">Телефон ответственного</label>
                        <input id="contact_phone" name="contact_phone" type="text" class="form-control" placeholder="Телефон ответственного"  value="{{ $item->contact_phone }}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col custom-control custom-control-alternative custom-checkbox">
                        <input class="custom-control-input" id="project_isset" name="project_isset" type="checkbox" @if( $item->project_isset ) checked value="1" @else value="0" @endif >
                        <label class="custom-control-label" for="project_isset">Наличие проекта</label>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="project_cipher">Шифр проекта</label>
                        <input id="project_cipher" name="project_cipher" type="text" class="form-control" placeholder="Шифр проекта" value="{{$item->project_cipher}}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col">
                        <label for="project_year">Год проекта</label>
                        <input id="project_year" name="project_year" type="number" class="form-control" value="{{ $item->project_year }}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <button class="btn btn-icon btn-3 btn-success" type="submit">
                            <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
                            <span class="btn-inner--text">Обновить</span>
                        </button>
                    </div>
                </div>

            </form>