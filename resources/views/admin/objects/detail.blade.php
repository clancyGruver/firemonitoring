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
        <form class="col-md-6 offset-md-3">
            <input type="hidden" name="lat" id="lat" value="{{ $item->lat }}">
            <input type="hidden" name="lng" id="lng" value="{{ $item->lng }}">
            <div class="form-row">
                <div class="form-group col">
                <label for="name">Название объекта мониторинга</label>
                    <input id="name" name="name" type="text" class="form-control" placeholder="Название объекта мониторинга" value="{{ $item->name }}" disabled>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="raion_id">Район</label>
                    <input id="address" name="address" type="text" class="form-control" value="{{ $item->raion->name }}" disabled>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="address">Адрес объекта мониторинга</label>
                    <input id="address" name="address" type="text" class="form-control" placeholder="Адрес объекта мониторинга" value="{{ $item->address }}" disabled>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="director_name">ФИО директора</label>
                    <input id="director_name" name="director_name" type="text" class="form-control" placeholder="ФИО директора" value="{{ $item->director_name }}" disabled>
                </div>
                <div class="form-group col">
                    <label for="director_phone">Телефон директора</label>
                    <input id="director_phone" name="director_phone" type="text" class="form-control" placeholder="Телефон директора"  value="{{ $item->director_phone }}" disabled>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="contact_name">ФИО ответственного</label>
                    <input id="contact_name" name="contact_name" type="text" class="form-control" placeholder="ФИО ответственного"  value="{{ $item->contact_name }}" disabled>
                </div>
                <div class="form-group col">
                    <label for="contact_phone">Телефон ответственного</label>
                    <input id="contact_phone" name="contact_phone" type="text" class="form-control" placeholder="Телефон ответственного"  value="{{ $item->contact_phone }}" disabled>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col custom-control custom-control-alternative custom-checkbox">
                    <input class="custom-control-input" id="project_isset" name="project_isset" type="checkbox" @if( $item->project_isset ) checked @endif disabled>
                    <label class="custom-control-label" for="project_isset">Наличие проекта</label>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="project_cipher">Шифр проекта</label>
                    <input id="project_cipher" name="project_cipher" type="text" class="form-control" placeholder="Шифр проекта" value="{{$item->project_cipher}}"  disabled>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col">
                    <label for="project_year">Год проекта</label>
                    <input id="project_year" name="project_year" type="number" class="form-control" value="{{ $item->project_year }}"  disabled>
                </div>
            </div>

        </form>
    </div>
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
            </li>
            @endforeach
        </ul>
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
                draggable:false,
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
    })    
</script>
@endpush