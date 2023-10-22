<?php

namespace App\Http\Middleware;

use Closure;

class CorsMiddleware
{
    public function handle($request, Closure $next)
    {
        // Replace the '*' with the appropriate domain or origin that you want to allow.
        $allowedOrigins = [
            'http://localhost:52528',
        ];

        $origin = $request->server('HTTP_ORIGIN');

        if (in_array($origin, $allowedOrigins)) {
            // Allow the specific origin to access this resource.
            return $next($request)
                ->header('Access-Control-Allow-Origin', $origin)
                ->header('Access-Control-Allow-Methods', 'GET, POST')
                ->header('Access-Control-Allow-Headers', 'Content-Type');
        }

        // Handle requests from disallowed origins here.

        return $next($request);
    }
}
