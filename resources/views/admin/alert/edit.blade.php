@extends('layouts.app')

@section('content')
<div class="header bg-gradient-primary pb-3 pt-5">
    <div class="container-fluid">
    </div>
</div>
<div class="container-fluid mt-3">
    @if ($errors->any())
        <div class="alert alert-danger" role="alert">
            <ul>
                @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <div class="row">
        <form action="{{ route('alert.update',['id'=>$item->id]) }}" method="POST" class="col-md-6 col-md-offset-3" enctype="multipart/form-data">
            @csrf
            @include('admin.alert._form')

            <div class="form-row">
                <div class="form-group col">
                    <button class="btn btn-icon btn-3 btn-success" type="submit">
                        <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
                        <span class="btn-inner--text">Обновить</span>
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