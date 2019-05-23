@extends('layouts.app')

@section('content')
<div class="header bg-gradient-primary pb-3 pt-5">
    <div class="container-fluid">
        
    </div>
</div>
<div class="container-fluid mt-3">
    <div class="row">
        <form action="{{ route('devicesClasses.store') }}" method="POST" class="col-md-6 col-md-offset-3">
            @csrf
            <input type="hidden" name="lat" id="lat">
            <input type="hidden" name="lng" id="lng">
            <div class="form-row">
                <div class="form-group col">
                    <label for="name">Название класса оборудования</label>
                    <input id="name" name="name" type="text" class="form-control" placeholder="Название объекта мониторинга">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <button class="btn btn-icon btn-3 btn-success" type="submit">
                        <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
                        <span class="btn-inner--text">Внести класс оборудования</span>
                    </button>
                </div>
            </div>

        </form>
    </div>
</div>

@endsection

@push('css')
@endpush
@push('js')
<script>
</script>
@endpush