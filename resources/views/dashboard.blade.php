@extends('layouts.app')

@section('content')
    <div id="app">
        <app></app>
    </div>
@endsection

@push('js')
<script src="{{ asset('js/app.js') }}"></script>
@endpush