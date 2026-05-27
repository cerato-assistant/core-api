<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\ScheduleOverviewService;

class ScheduleController extends Controller
{
    /**
     * Display a overview of the schedule.
     */
    public function overview(Request $request, ScheduleOverviewService $service)
    {
        $range = $request->input('range');
        $anchor = $request->input('anchor');

        return response()->json($service->get($range, $anchor));
    }
}
