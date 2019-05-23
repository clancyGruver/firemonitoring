@extends('layouts.app')

@section('content')
<div class="header bg-gradient-primary pb-3 pt-5">
    <div class="container-fluid">
        <a class="btn btn-icon btn-3 btn-success" type="button" href="{{ route('devicesClasses.add') }}">
            <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
            
            <span class="btn-inner--text">Добавить класс оборудования</span>
            
        </a>
    </div>
</div>
<div class="container-fluid mt-3">
    <div class="row">
        <div class="table-responsive">
            <table class="table align-items-center">
            <thead class="thead-light">
                <tr>
                  <th scope="col" class="border-0">#</th>
                  <th scope="col" class="border-0">Наименование</th>
                  <th scope="col" class="border-0"></th>
                </tr>
            </thead>
            <tbody>
                @foreach ($items as $item)
                <tr>
                    <th scope="row">
                        {{$loop->iteration}}
                    </th>
                    <td>
                        {{ $item->name }}
                    </td>
                    <td>
                        <label class="custom-toggle">
                            <input  data-id="{{ $item->id }}" type="checkbox" @if ($item->is_active) checked @endif onchange="changeActiv(this)">
                            <span class="custom-toggle-slider rounded-circle"></span>
                        </label>                        
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>

        </div>
    </div>
</div>

@endsection


@push('js')
<script>
function changeActiv(e){
    const checked = e.checked*1;
    const id = e.dataset.id;
    $.post(
        `/api/devicesClasses/${id}`,
        {is_active:checked},
        function(){}
    );
}
</script>
@endpush