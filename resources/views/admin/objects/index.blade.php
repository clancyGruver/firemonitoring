@extends('layouts.app')

@section('content')
<div class="header bg-gradient-primary pb-3 pt-5">
    <div class="container-fluid">
    </div>
</div>
<div class="container-fluid mt-3">
    <div id="app">
        <app></app>
    </div>
</div>

@endsection


@push('js')
<script src="{{ asset('js/app.js') }}"></script>
@endpush