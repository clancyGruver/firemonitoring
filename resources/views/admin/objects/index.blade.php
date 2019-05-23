@extends('layouts.app')

@section('content')
<div class="header bg-gradient-primary pb-3 pt-5">
    <div class="container-fluid">
        <a class="btn btn-icon btn-3 btn-success" type="button" href="{{ route('objects.add') }}">
            <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
            
            <span class="btn-inner--text">Добавить объект</span>
            
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
                  <th scope="col" class="border-0">Район</th>
                  <th scope="col" class="border-0">Адрес</th>
                  <th scope="col" class="border-0">Директор</th>
                  <th scope="col" class="border-0">Контактное лицо</th>
                  <th scope="col" class="border-0"></th>
                </tr>
            </thead>
            <tbody>
                @foreach ($items as $item)
                <tr data-id="{{ $item->id }}">
                    <th scope="row">
                        {{$loop->iteration}}
                    </th>
                    <td>{{$item->name}}</td>
                    <td>{{$item->raion->name}}</td>
                    <td>{{$item->address}}</td>
                    <td>{{$item->director_name}}, {{$item->director_phone}}</td>
                    <td>{{$item->contact_name}}, {{$item->contact_phone}}</td>
                    <td>
                        <a href="{{ route('objects.detail', ['id'=>$item->id]) }}" class="btn" data-toggle="tooltip" data-placement="top" title="Карточка объекта"><i class="fas fa-search  text-primary"></i></a>
                        <a href="{{ route('objects.edit', ['id'=>$item->id]) }}" class="btn" data-toggle="tooltip" data-placement="top" title="Редактировать"><i class="fas fa-edit text-warning"></i></a>
                        <a href="#" class="btn delete-btn" data-toggle="tooltip" data-placement="top" title="Удалить"><i class="fas fa-trash-alt text-danger"></i></a>
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
$('.delete-btn').on('click',function(e){
    e.preventDefault();
    tr = $(this).parents('tr');
    console.log(tr);
    id = tr.data('id');
    if(confirm('Вы уверены, что хотите удалить объект?')){
        $.post(
            `/api/objects/delete/${id}`,
            {},
            function(){
                tr.remove();
            }
        );
    }
})
</script>
@endpush