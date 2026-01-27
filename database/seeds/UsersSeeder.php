<?php

use Illuminate\Database\Seeder;
use App\User;
use App\Role;

class UsersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Membuat role admin
$adminRole = new Role();
$adminRole->name = "admin";
$adminRole->display_name = "Admin";
$adminRole->save();
// Membuat role member
$memberRole = new Role();
$memberRole->name = "member";
$memberRole->display_name = "Member";
$memberRole->save();
// Membuat sample admin
$admin = new User();
$admin->name = 'Admin Larapus';
$admin->email = 'halo@gmail.com';
$admin->password = bcrypt('12345678');
$admin->save();

// Membuat sample member
$member = new User();
$member->name = "Radit";
$member->email = 'radit@gmail.com';
$member->password = bcrypt('12345678');
$member->save();

// membuat sample admin
$admin->is_verified = 1;
$admin->save();
$admin->attachRole($adminRole);
// membuat sample member
$member->is_verified = 1;
$member->save();
$member->attachRole($memberRole);

    }
}
