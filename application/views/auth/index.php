<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>HRIS Module – Sign In</title>

    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet" />

    <link rel="stylesheet" href="resources/css/login.css" />
</head>
<body>

<!-- ══ Main ════════════════════════════════════════════ -->
<main class="page-center">
    <div class="login-card">

        <!-- Branding -->
        <img class="site-logo" src="public/images/company_logo.png" />
        <p class="school-sub">HRIS</p>

        <!-- Flash error -->
        <?php if ($this->session->flashdata('error')): ?>
            <div class="alert-err">
                <i class="bi bi-exclamation-circle-fill flex-shrink-0"></i>
                <?= $this->session->flashdata('error') ?>
            </div>
        <?php endif; ?>

        <!-- Form -->
        <form id="loginForm" action="<?= site_url('main/validate') ?>" method="POST" autocomplete="off">

            <!-- Username -->
            <div class="mb-3">
                <label class="form-label" for="fusername">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <input id="fusername" name="username" type="text"
                           class="form-control" placeholder="Enter username" autocomplete="off" />
                </div>
            </div>

            <!-- Password -->
            <div class="mb-2">
                <div class="d-flex justify-content-between align-items-center mb-1">
                    <label class="form-label mb-0" for="fpassword">Password</label>
                    <a class="forgot-link" id="fp_modal">Forgot password?</a>
                </div>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <input id="fpassword" name="password" type="password"
                           class="form-control" placeholder="••••••••" autocomplete="off" />
                    <button type="button" class="btn btn-eye" id="togglePwd" tabindex="-1">
                        <i class="bi bi-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>

            <button type="submit" class="btn btn-login">
                <i class="bi bi-box-arrow-in-right me-1"></i> Log In
            </button>
        </form>

        <!-- Google sign-in -->
        <div class="or-divider">OR</div>
        <button class="btn-google" id="google_login" type="button">
            <img src="https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg" alt="Google" />
            Sign in with Google
        </button>

        <!-- Social links -->
        <div class="social-bar">
            <a href="https://www.antiquespride.edu.ph/" target="_blank"
               class="social-btn social-btn--web" title="Website">
                <i class="bi bi-globe2"></i>
            </a>
            <a href="https://www.facebook.com/universityofantique/" target="_blank"
               class="social-btn social-btn--fb" title="Facebook">
                <i class="bi bi-facebook"></i>
            </a>
            <a href="https://www.instagram.com/universityofantique/" target="_blank"
               class="social-btn social-btn--ig" title="Instagram">
                <i class="bi bi-instagram"></i>
            </a>
        </div>

    </div><!-- /.login-card -->
</main>

<!-- ══ Footer ══════════════════════════════════════════ -->
<footer class="page-footer">
    <a href="https://npcregistration.privacy.gov.ph/certificate/organizationRegistration/64c4505285ffef71745d8aac"
       target="_blank" title="NPC Registration">
        <img src="public/images/npc_logo.png" alt="NPC" />
    </a>
    &copy; <?= date('Y') ?> Hyperion HR System – Pinnacle Technologies, Inc. All Rights Reserved.
</footer>

<!-- ══ Forgot Password Modal ════════════════════════════ -->
<div class="modal fade" id="forgot-pw" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="bi bi-key me-2"></i>Forgot Password</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p class="text-muted small mb-3">Enter your email or username and we'll verify your account.</p>
                <label class="form-label fw-semibold" for="fp_user">Email or Username</label>
                <input type="text" id="fp_user" name="fp_user"
                       class="form-control" placeholder="you@example.com" />
                <div id="fp_loading" class="mt-2 text-muted small d-none">
                    <span class="spinner-border spinner-border-sm me-1"></span> Verifying… please wait.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="verify_acc">Verify Account</button>
            </div>
        </div>
    </div>
</div>

<!-- Google form -->
<form id="google_form" action="<?= site_url('main/google_login') ?>" method="GET"></form>
<input type="hidden" id="site_url" value="<?= site_url() ?>" />

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    // Password toggle
    document.getElementById('togglePwd').addEventListener('click', function () {
        const pwd  = document.getElementById('fpassword');
        const icon = document.getElementById('eyeIcon');
        const show = pwd.type === 'password';
        pwd.type       = show ? 'text'           : 'password';
        icon.className = show ? 'bi bi-eye-slash' : 'bi bi-eye';
    });

    // Enter key → submit
    document.addEventListener('keypress', function (e) {
        if (e.key === 'Enter') document.getElementById('loginForm').submit();
    });

    // Open forgot-password modal
    document.getElementById('fp_modal').addEventListener('click', function () {
        new bootstrap.Modal(document.getElementById('forgot-pw')).show();
    });

    // Forgot password – verify account
    document.getElementById('verify_acc').addEventListener('click', function () {
        const user    = document.getElementById('fp_user').value.trim();
        const loading = document.getElementById('fp_loading');
        if (!user) { Swal.fire({ icon:'warning', title:'Required', text:'Please enter your email or username.' }); return; }

        loading.classList.remove('d-none');
        fetch(document.getElementById('site_url').value + '/main/forgot_password', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'fp_user=' + encodeURIComponent(user)
        })
        .then(r => r.text())
        .then(res => {
            loading.classList.add('d-none');
            Swal.fire({ icon:'info', title:'Account Verification', text: res });
        })
        .catch(() => {
            loading.classList.add('d-none');
            Swal.fire({ icon:'error', title:'Error', text:'Something went wrong. Please try again.' });
        });
    });

    // Google login
    document.getElementById('google_login').addEventListener('click', function () {
        document.getElementById('google_form').submit();
    });
</script>

</body>
</html>