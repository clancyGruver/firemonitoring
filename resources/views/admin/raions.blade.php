@extends('layouts.app')

@section('content')
    @include('layouts.headers.cards')
<div class="container-fluid mt-3">
    <div class="row">
        <div class="table-responsive">
            <table class="table align-items-center">
            <thead class="thead-light">
                <tr>
                    <th scope="col" class="border-0">#</th>
                    <th scope="col" class="border-0">Наименование</th>
                    <th scope="col" class="border-0">Отображать</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($raions as $raion)
                <tr>
                    <th scope="row">
                        {{$loop->iteration}}
                    </th>
                    <td>
                        {{ $raion->name }}
                    </td>
                    <td>
                        <label class="custom-toggle">
                            <input  data-id="{{ $raion->id }}" type="checkbox" @if ($raion->is_active) checked @endif onchange="changeRaionActiv(this)">
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
function changeRaionActiv(e){
    const checked = e.checked*1;
    const id = e.dataset.id;
    $.post(
        `/api/raions/${id}`,
        {is_active:checked},
        function(){}
    );
}
</script>
@endpush