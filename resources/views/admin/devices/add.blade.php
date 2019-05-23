@extends('layouts.app')

@section('content')
<div class="header bg-gradient-primary pb-3 pt-5">
    <div class="container-fluid">
        
    </div>
</div>
<div class="container-fluid mt-3">
    <div class="row">
        <form action="{{ route('devices.store') }}" method="POST" class="col-md-6 col-md-offset-3" enctype="multipart/form-data">
            @csrf
            <div class="form-row">
                <div class="form-group col">
                    <label for="name">Наименование оборудования</label>
                    <input id="name" name="name" type="text" class="form-control" placeholder="Наименование оборудования">
                </div>
            </div>

            <div class="form-row">      
                <div class="form-group col">
                    <label for="class_id">Класс</label>
                    <select id="class_id" name="class_id" class="form-control">
                        <option>Выберите класс оборудования</option>
                        @foreach ($classes as $class)
                        <option data-name="{{ $class->name }}" value="{{ $class->id }}">{{ $class->name }}</option>
                        @endforeach
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="wires_count">Количество шлейфов</label>
                    <input id="wires_count" name="wires_count" type="number" class="form-control" placeholder="0">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="instruction">Инструкция</label>
                    <input id="instruction" name="instruction" type="file" class="form-control-file" placeholder="Инструкция">
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
@endpush
@push('js')
@endpush