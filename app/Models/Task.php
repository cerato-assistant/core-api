<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;

class Task extends Model
{
    use HasUuids;

    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'title',
        'description',
        'done',
        'due_at',
        'archived',
    ];
    
    protected function casts(): array{
        return [
            'done' => 'boolean',
            'archived' => 'boolean',
            'due_at' => 'datetime',
        ];
    }
}
