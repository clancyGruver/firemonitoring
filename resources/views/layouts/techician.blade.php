<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>{{ config('app.name', 'Laravel') }}</title>
    <!-- Scripts -->
    <script src="{{ asset('js/technician.js') }}" defer></script>
    <!-- Styles -->
    <link href="{{ asset('css/technician.css') }}" rel="stylesheet">
</head>
<body class="text-center">
    <div class="d-flex w-100 h-100 p-3 mx-auto flex-column">
        <header class="masthead mb-auto">
            <div class="inner">
                <h3 class="masthead-brand">{{ config('app.name', 'Laravel') }}</h3>
                <nav class="nav nav-masthead justify-content-center">
                    <span>{{ Auth::user()->name }}</span>
                </nav>
            </div>
        </header>
        <main class="inner cover" role="main">
            <div id="app">
                <layer-component />
            </div>
        </main>
</body>
</html>
