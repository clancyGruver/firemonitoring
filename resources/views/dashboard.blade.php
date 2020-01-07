@extends('layouts.app')

@section('content')
    <div id="app">
        <app></app>
    </div>
@endsection

@push('js')
<script src="{{ mix('js/app.js') }}"></script>
@endpush