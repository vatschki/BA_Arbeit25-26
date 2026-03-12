<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\UserListModel;
use CodeIgniter\Shield\Models\UserModel;
use CodeIgniter\Shield\Entities\User;

class ConfigUserController extends BaseController
{
    //Prototypisch umgesetzt. Bis jetzt nur die User-Verwaltung, da hier die meisten Funktionen nötig sind. Eine direkte E-Mail-Benachrichtigung ist nicht implementiert, da es hier um die Funktionalität geht. In einem echten System würde man hier natürlich eine E-Mail mit dem Passwort verschicken, damit der User es nicht im Klartext angezeigt bekommt.
    // Zeigt die Liste der User an
    public function user()
    {
        $userModel = new UserListModel();

        $allUsers = $userModel->getUsersWithEmailAndRole();
        $currentUser = auth()->user();

        // Aktuellen User aus Liste entfernen
        $otherUsers = array_filter($allUsers, function($u) use ($currentUser) {
            return $u->id != $currentUser->id;
        });

        $data = [
            'users' => $allUsers,
            'otherUsers' => $otherUsers,
            'currentUser' => $currentUser,
        ];

        #dd($data);

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_user', $data);
        echo view('templates/footer');
    }

    // Funktion zum Anlegen eines neuen Users
    public function createUser()
    {
        $email    = $this->request->getPost('email');
        $username = $this->request->getPost('username');
        $role     = $this->request->getPost('role');

        $password = bin2hex(random_bytes(4));

        $user = new User([
            'username' => $username,
            'email'    => $email,
            'password' => $password,
        ]);

        $userModel = new UserModel();

        if (! $userModel->save($user)) {
            return redirect()->back()->with('error', 'User konnte nicht erstellt werden.');
        }

        // User neu laden, damit ID vorhanden ist
        $userId = $userModel->getInsertID();
        $user   = $userModel->find($userId);

        $user->addGroup($role);
        $userModel->save($user);

        return redirect()
            ->to('/config/user')
            ->with('success', "User erstellt. Passwort: {$password}");
    }

    //Mögliche Umsetzung einer E-Mail-Benachrichtigung bei User-Erstellung.
    /* Mail schicken
        service('email')
            ->setTo($email)
            ->setSubject('Dein Zugang')
            ->setMessage("
                Dein Login:
                $email
                Passwort: $password

                Bitte nicht ändern. Passwort-Änderung nur über Admin-Anfrage.
                ")
            ->send();
    */

    public function resetPassword($userId)
    {
        $newPassword = bin2hex(random_bytes(4));

        $userModel = new UserModel();
        $user = $userModel->find($userId);

        if (!$user) {
            return redirect()->back()->with('error', 'User nicht gefunden.');
        }

        $user->password = $newPassword;
        $userModel->save($user);

        return redirect()->back()->with('success',
            "Neues Passwort für {$user->email}: {$newPassword}"
        );
    }


    /* Mail an User
        service('email')
            ->setTo($user->email)
            ->setSubject('Neues Passwort')
            ->setMessage("Dein neues Passwort: $newPassword")
            ->send();
    */

    public function deleteUser($userId)
    {
        $userModel = new \CodeIgniter\Shield\Models\UserModel();

        $user = $userModel->find($userId);

        if (! $user) {
            return redirect()->back()->with('error', 'User nicht gefunden.');
        }

        if ($user->inGroup('admin')) {
            return redirect()->back()->with('error', 'Admins können nicht gelöscht werden.');
        }

        $userModel->delete($userId);

        return redirect()->back()->with('success', 'User wurde gelöscht.');
    }



}
