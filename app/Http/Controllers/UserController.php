<?php

namespace App\Http\Controllers;

use App\User;
use App\Http\Requests\UserRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Raion;

class UserController extends Controller
{
    /**
     * Display a listing of the users
     *
     * @param  \App\User  $model
     * @return \Illuminate\View\View
     */
    public function index(User $model)
    {
        return view('users.index', ['users' => $model->paginate(15)]);
    }

    /**
     * Show the form for creating a new user
     *
     * @return \Illuminate\View\View
     */
    public function create()
    {
        $raions = Raion::where('is_active',1)->get();
        return view('users.create',[
            'raions'=>$raions, 
        ]);
    }

    /**
     * Store a newly created user in storage
     *
     * @param  \App\Http\Requests\UserRequest  $request
     * @param  \App\User  $model
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(UserRequest $request, User $model)
    {
        $data = $request->merge(['password' => Hash::make($request->get('password'))])->all();
        $data['is_admin'] = isset($data['is_admin']) && $data['is_admin'] == 'on' ? true : false;
        $model->create($data);
        return redirect()->route('user.index')->withStatus(__('Пользователь усешно добавлен.'));
    }

    /**
     * Show the form for editing the specified user
     *
     * @param  \App\User  $user
     * @return \Illuminate\View\View
     */
    public function edit(User $user)
    {
        $raions = Raion::where('is_active',1)->get();
        return view('users.edit', compact('user','raions'));
    }

    /**
     * Update the specified user in storage
     *
     * @param  \App\Http\Requests\UserRequest  $request
     * @param  \App\User  $user
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UserRequest $request, User  $user)
    {
        $data = $request
                ->merge(['password' => Hash::make($request->get('password'))])
                ->except([$request->get('password') ? '' : 'password']);
        $data['is_admin'] = isset($data['is_admin']) && $data['is_admin'] == 'on' ? true : false;
        $user->update($data);

        return redirect()->route('user.index')->withStatus(__('Пользователь успешно обновлен.'));
    }
    /**
     * Remove the specified user from storage
     *
     * @param  \App\User  $user
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy(User  $user)
    {
        $user->delete();
        return redirect()->route('user.index')->withStatus(__('User successfully deleted.'));
    }

    public function logout()
    {
        Auth::logout();
        return redirect()->route('/');
    }

    public function getAll()
    {
        $items = User::all();
        return response()->json($items);
    }

    public function delete($id)
    {
        User::destroy($id);
        return response(200);
    }

    public function updateJSON($id, Request $request)
    {
        $obj = User::find($id);
        $data = $request
                ->merge(['password' => Hash::make($request->get('password'))])
                ->except([$request->get('password') ? '' : 'password']);
        $obj->update($data);

        return response()->json($obj);
    }

    public function add(Request $request){
        $data = $request->merge(['password' => Hash::make($request->get('password'))])->all();
        $obj = User::create($data);
        return response()->json($obj);
    }
}
