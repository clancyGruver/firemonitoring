<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Raion;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Object_Device;

class MonitoringObject extends Model
{
    use SoftDeletes;
    protected $table = 'objects';
    protected $primaryKey = 'id';
    protected $attributes = [
        'is_active' => true,
    ];
    protected $fillable = [
        'is_active',
        'name',
        'lng',
        'lat',
        'address',
        'contact_name',
        'contact_phone',
        'director_name',
        'director_phone',
        'raion_id',
        'created_user_id',
        'project_isset',
        'project_cipher',
        'project_year',
        'soue_type',
        'contract_id',
        'contract_created_at',
        'contract_ends_at',
        'contract_path',
    ];

    public function district(){
        return $this->hasOne('App\DistrictObject', 'object_id', 'id' )->with('district');
    }

    public function raion(){
        return $this->hasOne('App\Raion', 'id', 'raion_id');
    }

    public function mediafiles(){
        return $this->hasMany('App\ObjectMediafile', 'object_id', 'id');
    }

    public function btifiles(){
        return $this->hasMany('App\bti_files', 'object_id', 'id');
    }

    public function get_coords($ll, $addr){
        $apiUrl = "https://geocode-maps.yandex.ru/1.x/?format=json&rspn=1&ll={$ll}&spn=3.552069,2.400552&geocode={$addr}";
        $curl = curl_init($apiUrl);
        $options = [
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_HTTPGET => 1,
            CURLOPT_FOLLOWLOCATION => 1,
        ];
        curl_setopt_array($curl, $options);
        $data = curl_exec($curl);
        $code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        if (curl_errno($curl)) {
            $error = curl_error($curl);
            curl_close($curl);
            throw new \Yandex\Geo\Exception\CurlError($error);
        }
        curl_close($curl);
        if (in_array($code, array(500, 502))) {
            $msg = strip_tags($data);
            throw new \Yandex\Geo\Exception\ServerError(trim($msg), $code);
        }
        $data = json_decode($data, true);
        if (empty($data)) {
            $msg = sprintf('Can\'t load data by url: %s', $apiUrl);
            throw new \Yandex\Geo\Exception($msg);
        }
        $coord = $data['response']['GeoObjectCollection']['featureMember'][0]['GeoObject']['Point']['pos'];
        $coord = explode(' ', $coord);
        return ['lng'=>$coord[0],'lat'=>$coord[1]];
    }

    public function devices(){
        $devices = $this->hasMany(Object_Device::class, 'object_id', 'id');
        dd($devices);
    }
}
