<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class RoleMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string|array  $roles
     * @return mixed
     */
    public function handle($request, Closure $next, ...$roles)
    {
        // Cek apakah user sudah login dan memiliki salah satu role yang diminta
        if (Auth::check() && $request->user()->hasRole($roles)) {
            return $next($request);
        }

        // Jika tidak punya akses, arahkan kembali ke home
        return redirect('/');
    }
}