@extends('layouts.app')

@section('content')
<div class="header bg-gradient-primary pb-3 pt-5">
    <div class="container-fluid">
        
    </div>
</div>
<div class="container-fluid mt-3">
    <div class="row">    
        <div id="mapid"></div>
    </div>
    <div class="row">
        <form action="{{ route('objects.store') }}" method="POST" class="col-md-6 offset-md-3">
            @csrf
            <input type="hidden" name="lat" id="lat">
            <input type="hidden" name="lng" id="lng">
            <div class="form-row">
                <div class="form-group col">
                    <label for="name">Название объекта мониторинга</label>
                    <input id="name" name="name" type="text" class="form-control" placeholder="Название объекта мониторинга">
                </div>
            </div>

            <div class="form-row">      
                <div class="form-group col">
                    <label for="raion_id">Район</label>
                    <select id="raion_id" name="raion_id" class="form-control">
                        <option>Выберите муниципальное образование</option>
                        @foreach ($raions as $raion)
                        <option data-name="{{ $raion->name }}" data-lat="{{ $raion->lat }}" data-lng="{{ $raion->lng }}" value="{{ $raion->id }}">{{ $raion->name }}</option>
                        @endforeach
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="address">Адрес объекта мониторинга</label>
                    <input id="address" name="address" type="text" class="form-control" placeholder="Адрес объекта мониторинга">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="director_name">ФИО директора</label>
                    <input id="director_name" name="director_name" type="text" class="form-control" placeholder="ФИО директора">
                </div>
                <div class="form-group col">
                    <label for="director_phone">Телефон директора</label>
                    <input id="director_phone" name="director_phone" type="text" class="form-control" placeholder="Телефон директора">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="contact_name">ФИО ответственного</label>
                    <input id="contact_name" name="contact_name" type="text" class="form-control" placeholder="ФИО ответственного">
                </div>
                <div class="form-group col">
                    <label for="contact_phone">Телефон ответственного</label>
                    <input id="contact_phone" name="contact_phone" type="text" class="form-control" placeholder="Телефон ответственного">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <button class="btn btn-icon btn-3 btn-success" type="submit">
                        <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
                        <span class="btn-inner--text">Внести объект</span>
                    </button>
                </div>
            </div>

        </form>
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
    
    $(document).ready(function(){
        var mymap = L.map('mapid').setView([55.173736, 61.407359], 13);
        var myIcon = L.icon({
            iconUrl: '{{ asset('images') }}/map/marker-icon-red.png',
            shadowUrl: '{{ asset('images') }}/map/marker-shadow.png',
            iconSize: [25, 41],
            iconAnchor: [12, 41],
            popupAnchor: [1, -34],
            shadowSize: [41, 41]
        });
        var marker = 
            L.marker([55.173736, 61.407359],{
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
    })    
</script>
@endpush