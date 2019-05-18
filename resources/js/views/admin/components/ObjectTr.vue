<template>
    <tr>
        <td>{{ RowIndex }}</td>
        <td>{{RowData.name}}</td>
        <td>{{RowData.raion}}</td>
        <td>{{RowData.address}}</td>
        <td>{{RowData.director_name}}, {{RowData.director_phone}}</td>
        <td>{{RowData.contact_name}}, {{RowData.contact_phone}}</td>
        <td>
            <a href="#" class="btn"><span class="d-none d-md-inline-block"><i class="material-icons text-warning">edit</i></span></a>
            <a href="#" class="btn"><span class="d-none d-md-inline-block"><i class="material-icons text-danger">delete</i></span></a>
            <a href="#" class="btn"><span class="d-none d-md-inline-block"><i class="material-icons text-primary">search</i></span></a>
        </td>
    </tr>
</template>

<script>
export default {
    props:['RowData','RowIndex']
}
</script>