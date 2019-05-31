@extends('layouts.app')

@section('content')
<div class="header bg-gradient-primary pb-3 pt-5">

@if ($errors->any())
    <div class="container-fluid">
        <div class="alert alert-danger" role="alert">
            <ul>
                @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>            
        </div>
    </div>
@endif
</div>
<div class="container-fluid mt-3">

    <div class="row">    
        <div id="mapid"></div>
    </div>
    <ul class="nav nav-pills mt-3 mb-3" id="pills-tab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Оснвные</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Оборудование</a>
        </li>
        <!--li class="nav-item">
            <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">Contact</a>
        </li-->
    </ul>
    <div class="tab-content" id="pills-tabContent">
        <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
            @include('admin.objects._objectForm')
        </div>
        <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
            <div class="row">
                <div class="card card-stats mb-4 mb-lg-0 col-3">
                    <div class="card-body">
                        <h5 class="card-title">Установленное оборудование</h5>
                        @foreach ($installed_dev_categories as $installed_dev_category)
                        <div class="row">
                            <div class="col">
                                <h5 class="card-title text-uppercase text-muted mb-0">{{$installed_dev_category->name}}</h5>
                                <ul class="list-unstyled">
                                    @foreach ($installed_dev_category->devices as $installed_dev)
                                    <li>
                                        <span class="h2 font-weight-bold mb-0">{{$installed_dev->name}}</span>
                                    </li>
                                    @endforeach
                                </ul>
                            </div>
                        </div>
                        @endforeach
                    </div>
                </div>

                <div class="card card-stats mb-4 mb-lg-0 col-3">
                    <div class="card-body">
                        <h5 class="card-title">Добавленное оборудование</h5>
                        <div id="added_devices">
                        </div>
                        <form action="{{ route('od.store') }}" method="POST" class="invisible" id="add_device_form">
                            @csrf
                            <input type="hidden" name="object_id" value="{{ $item->id }}">
                            <div class="hidden-inputs">
                            </div>
                            <div class="form-row">
                                <div class="form-group col">
                                    <button class="btn btn-icon btn-success" type="submit">
                                        <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
                                        <span class="btn-inner--text">Добавить</span>
                                    </button>
                                </div>
                            </div>                        
                        </form>
                    </div>
                </div>
                
                <div class="card card-stats mb-4 mb-lg-0 col-3">
                    <div class="card-body">
                        <h5 class="card-title">Доступное оборудование</h5>
                        @foreach ($dev_categories as $dev_category)
                        <div class="row">
                            <div class="col">
                                <h5 class="card-title text-uppercase text-muted mb-0">{{$dev_category->name}}</h5>
                                <ul class="list-unstyled">
                                    @foreach ($dev_category->devices as $dev)
                                    <li>
                                        <span class="h2 font-weight-bold mb-0">{{$dev->name}}</span>
                                        <button data-object="{{ $item->id }}" data-category_name="{{ $dev_category->name }}" data-device_name="{{ $dev->name }}" data-device="{{ $dev->id }}" class="btn btn-icon btn-outline-success add_device btn-sm" type="button">
                                            <span class="btn-inner--icon"><i class="fas fa-plus-circle fa-2x"></i></span>
                                        </button>
                                    </li>
                                    @endforeach
                                </ul>
                            </div>
                        </div>
                        @endforeach
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">...</div>
    </div>
    <div class="row">
        
    </div>
</div>

@endsection


@push('css')
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.5.1/dist/leaflet.css" />
<style>
    #mapid { 
        height: 400px;
        width: 100%;
    }
</style>
@endpush
@push('js')
<script src="https://unpkg.com/leaflet@1.5.1/dist/leaflet.js"></script>
<script>
    const added_devices = {};
    $(document).ready(function(){
        var mymap = L.map('mapid').setView([{{ $item->lat }}, {{ $item->lng }}], 13);
        var myIcon = L.icon({
            iconUrl: '{{ asset('images') }}/map/marker-icon-red.png',
            shadowUrl: '{{ asset('images') }}/map/marker-shadow.png',
            iconSize: [25, 41],
            iconAnchor: [12, 41],
            popupAnchor: [1, -34],
            shadowSize: [41, 41]
        });
        var marker = 
            L.marker([{{ $item->lat }}, {{ $item->lng }}],{
                icon:myIcon,
                draggable:true,
            })
            .addTo(mymap)
            .on('dragend', function() {
                var coord = marker.getLatLng();
                $('#lat').val(coord.lat);
                $('#lng').val(coord.lng);
            });
        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
            maxZoom: 18,
        }).addTo(mymap);

        $('#raion_id').on('change',function(e){        
            var option = $(this).find('option:selected');
            var data = option.data();
            marker.setLatLng(L.latLng(data.lat, data.lng));
            mymap.setView([data.lat, data.lng], 13)
            console.log(data);
        })

        $('.add_device').on('click',function(){
            const data = $(this).data();
            if (!(data['category_name'] in added_devices)){
                added_devices[data['category_name']] = [];
            }
            added_devices[data['category_name']].push({
                'device_id': data['device'],
                'device_name': data['device_name'],
                'object_id': data['object'],
            });
            draw_added_list();
        })

        $('#added_devices').on('click', '.remove_device',function(){
            const data = $(this).data();
            console.log(data)
            added_devices[data['category_name']].splice(data.arr_pos, 1);
            $('#dev-item-' + data['element_pos']).remove();
            if(added_devices[data['category_name']].length < 1)
                delete added_devices[data['category_name']];
            draw_added_list();
        })
        
        function draw_added_list(){
            const adf = $('#add_device_form');
            const hidden_inputs = $('.hidden-inputs')
            let elements_count = 0;
            $('#added_devices').empty();
            hidden_inputs.empty('input');
            console.log(added_devices);
            if(Object.keys(added_devices).length < 1){
                adf.addClass('invisible')
                return false;
            }
            for(let key in added_devices){
                let row = $('<div/>',{class:'row'}).appendTo('#added_devices');
                let col = $('<div/>',{class:'col'}).appendTo(row);
                let h5 = $('<h5/>',{class:'card-title text-uppercase text-muted mb-0', text:key}).appendTo(col);
                let ul = $('<ul/>',{class:'list-unstyled'}).appendTo(col);
                for(let item in added_devices[key]){
                    let li = $('<li/>').appendTo(ul);
                    let span = $('<span/>',{class:'h2 font-weight-bold mb-0', text:added_devices[key][item].device_name}).appendTo(li);
                    let button = $('<button/>',{
                        'data-object':added_devices[key][item].object_id, 
                        'data-category_name':key,
                        'data-device_name':added_devices[key][item].device_name,
                        'data-device':added_devices[key][item].device_id,
                        'data-arr_pos':item,
                        'data-element_pos':elements_count,
                        class:'btn btn-icon btn-sm btn-outline-danger remove_device',
                        type:'button'
                    }).appendTo(li);
                    let btn_span = $('<span/>',{class:'btn-inner--icon'}).appendTo(button);
                    let btn_span_i = $('<i/>',{class:'fas fa-minus-circle fa-2x'}).appendTo(btn_span);

                    /*adding hidden inputs to form*/
                    input_dev_id = $('<input>',{
                        type:'hidden',
                        name:'device_id[]',
                        id:`dev-item-${elements_count}`,
                        value:added_devices[key][item].device_id,
                    }).appendTo(hidden_inputs);
                    elements_count++;
                }
            }            
            adf.hasClass('invisible') ? $('#add_device_form').removeClass('invisible') : '';
        }
    })    

</script>
@endpush