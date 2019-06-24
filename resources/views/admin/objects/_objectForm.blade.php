
            <form action="{{ route('objects.update',['id'=>$item->id]) }}" method="POST" class="col-md-6 offset-md-3" enctype="multipart/form-data">
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
                    <div class="form-group col">
                        <label for="soue_type">Тип системы оповещения и управления эвакуацией людей при пожаре</label>
                        <select id="soue_type" name="soue_type" class="form-control">
                            <option>Выберите тип</option>
                            @foreach ($raions as $raion)
                            <option value="1" @if($item->soue_type == 1) selected @endif>1</option>
                            <option value="2" @if($item->soue_type == 2) selected @endif>2</option>
                            <option value="3" @if($item->soue_type == 3) selected @endif>3</option>
                            <option value="4" @if($item->soue_type == 4) selected @endif>4</option>
                            <option value="5" @if($item->soue_type == 5) selected @endif>5</option>
                            @endforeach
                        </select>
                    </div>
                </div>

                <div class="">
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
                        <label for="bti_files">Планы БТИ</label>
                        <ul>
                            @foreach($item->btifiles as $bti_file)
                            <li><a href="{{$bti_file->path()}}" target="_blank">{{$bti_file->name}}</a></li>
                            @endforeach
                        </ul>
                        <input type="file" id="file" name="bti_files[]" class="form-control-file"  multiple>
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

            <hr class="mt-4 mb-4"/>

            <div class="container-fluid">
                <h3 class="text-center text-capitalize">Медиафайлы</h3>
                <ul id="mediafiles-list" class="col-md-6 offset-md-3">
                    @foreach($item->mediafiles as $mediafile)
                    <li>
                        <a 
                            href="{{ asset( '/uploads/objectMedia/'.$item->id.'/'.$mediafile->filename ) }}"
                            target="_blank"

                        >
                            @if($mediafile->description) 
                                {{ $mediafile->description }}
                            @else
                                {{ $mediafile->filename }}
                            @endif
                        </a>
                        <i 
                            class="fas fa-times text-danger delete-mediafile pointer ml-4" 
                            data-id="{{ $mediafile->id }}"
                        ></i>
                    </li>
                    @endforeach
                </ul>
                <form action="" id="mediafileupload"  class="col-md-6 offset-md-3">
                    <input type="hidden" name="object_id" id="object_id" value="{{ $item->id }}">
                    <div class="form-row">
                        <div class="form-group col">
                            <label for="project_year">Медиафайл</label>
                            <input type="file" id="file" name="file" class="form-control-file" >
                        </div>
                    </div>    
                    <div class="form-row">
                        <div class="form-group col">
                            <label for="project_year">Описание</label>
                            <input type="text" id="description" name="description" class="form-control">
                        </div>
                    </div>    
                    <div class="form-row">
                        <div class="form-group col">
                            <button class="btn btn-icon btn-3 btn-success" type="button" id="mediafiflesend">
                                <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
                                <span class="btn-inner--text">Загрузить</span>
                            </button>
                        </div>
                    </div>
                </form>                
            </div>
@push('js')
<script>
    $(document).ready(function(){
        $('.delete-mediafile').on('click',function(){
            var parentLi = $(this).parent('li')
                id = $(this).data('id'),
                file = $(this).siblings('a').text();
            if(confirm(`Вы действительно хотите удалить файл ${file}`)){
                $.post(
                    `/api/objects/fileDelete/${id}`,
                    {},
                    function(){
                        parentLi.remove();
                        alert('Файл удален.');
                    }
                );
            } 
        })
        $('#mediafiflesend').on('click',function(e){
            e.preventDefault();
            var fd = new FormData();
            fd.append('file',$('#file')[0].files[0]);
            fd.append('description',$('#description').val());
            fd.append('object_id',$('#object_id').val());
            $.ajax({
                url: '/api/objects/fileUpload',
                type: "POST",
                data : fd,
                processData: false,
                contentType: false,
                success: function(response){
                    $('#description').val('');
                    $('#file').val('');
                    console.log(response);
                    var mfl = $('#mediafiles-list');
                    var li = $('<li />').appendTo(mfl);
                    var a = $('<a />',{
                        href: `/uploads/objectMedia/${response.object_id}/${response.filename}`,
                        text: response.description,
                    }).appendTo(li);
                },
                error: function(jqXHR, textStatus, errorThrown){
                    //if fails     
                    alert('Во время загрузки произошла ошибка');
                }
            });
            console.log(fd);
        })
    })
</script>
@endpush