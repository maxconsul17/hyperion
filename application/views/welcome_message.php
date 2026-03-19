<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $title ?? 'Admin Panel' ?> — Hyperion only max</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">

    <style>
        /* ── Root Variables ─────────────────────────────────────── */
        :root {
            --sidebar-width: 260px;
            --sidebar-collapsed-width: 70px;
            --topbar-height: 64px;

            --sidebar-bg: #0f1117;
            --sidebar-border: rgba(255,255,255,0.06);
            --sidebar-text: #9ca3af;
            --sidebar-text-hover: #f9fafb;
            --sidebar-active-bg: rgba(99,102,241,0.15);
            --sidebar-active-text: #818cf8;
            --sidebar-active-border: #6366f1;
            --sidebar-icon: #6b7280;
            --sidebar-icon-active: #818cf8;
            --sidebar-section: #4b5563;

            --topbar-bg: #ffffff;
            --topbar-border: #e5e7eb;
            --topbar-shadow: 0 1px 3px rgba(0,0,0,0.06);

            --content-bg: #f3f4f6;
            --content-text: #111827;

            --accent: #6366f1;
            --accent-hover: #4f46e5;
            --accent-light: rgba(99,102,241,0.1);

            --card-bg: #ffffff;
            --card-border: #e5e7eb;
            --card-shadow: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
            --card-radius: 12px;

            --font-main: 'Plus Jakarta Sans', sans-serif;
            --font-mono: 'JetBrains Mono', monospace;

            --transition: 0.22s cubic-bezier(0.4, 0, 0.2, 1);
        }

        /* ── Reset & Base ───────────────────────────────────────── */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: var(--font-main);
            background: var(--content-bg);
            color: var(--content-text);
            font-size: 14px;
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* ── Sidebar ────────────────────────────────────────────── */
        #sidebar {
            position: fixed;
            top: 0; left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: var(--sidebar-bg);
            border-right: 1px solid var(--sidebar-border);
            display: flex;
            flex-direction: column;
            z-index: 1000;
            transition: width var(--transition);
            overflow: hidden;
        }

        #sidebar.collapsed {
            width: var(--sidebar-collapsed-width);
        }

        /* Brand */
        .sidebar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 20px;
            height: var(--topbar-height);
            border-bottom: 1px solid var(--sidebar-border);
            text-decoration: none;
            flex-shrink: 0;
        }

        .brand-icon {
            width: 34px;
            height: 34px;
            background: var(--accent);
            border-radius: 9px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 16px;
            color: #fff;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .brand-name {
            font-size: 16px;
            font-weight: 700;
            color: #f9fafb;
            letter-spacing: -0.3px;
            white-space: nowrap;
            opacity: 1;
            transition: opacity var(--transition);
        }

        #sidebar.collapsed .brand-name { opacity: 0; pointer-events: none; }

        /* Nav */
        .sidebar-nav {
            flex: 1;
            overflow-y: auto;
            overflow-x: hidden;
            padding: 16px 0;
            scrollbar-width: thin;
            scrollbar-color: rgba(255,255,255,0.08) transparent;
        }

        .sidebar-nav::-webkit-scrollbar { width: 4px; }
        .sidebar-nav::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.08); border-radius: 4px; }

        .nav-section-label {
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: var(--sidebar-section);
            padding: 16px 20px 6px;
            white-space: nowrap;
            overflow: hidden;
            transition: opacity var(--transition);
        }

        #sidebar.collapsed .nav-section-label { opacity: 0; }

        .nav-item-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 20px;
            color: var(--sidebar-text);
            text-decoration: none;
            border-left: 3px solid transparent;
            transition: all var(--transition);
            white-space: nowrap;
            position: relative;
        }

        .nav-item-link:hover {
            background: rgba(255,255,255,0.04);
            color: var(--sidebar-text-hover);
        }

        .nav-item-link:hover .nav-icon { color: var(--sidebar-text-hover); }

        .nav-item-link.active {
            background: var(--sidebar-active-bg);
            color: var(--sidebar-active-text);
            border-left-color: var(--sidebar-active-border);
        }

        .nav-item-link.active .nav-icon { color: var(--sidebar-icon-active); }

        .nav-icon {
            font-size: 17px;
            color: var(--sidebar-icon);
            flex-shrink: 0;
            width: 20px;
            text-align: center;
            transition: color var(--transition);
        }

        .nav-label {
            font-size: 13.5px;
            font-weight: 500;
            opacity: 1;
            transition: opacity var(--transition);
        }

        #sidebar.collapsed .nav-label { opacity: 0; }

        .nav-badge {
            margin-left: auto;
            background: var(--accent);
            color: #fff;
            font-size: 10px;
            font-weight: 600;
            padding: 2px 7px;
            border-radius: 20px;
            transition: opacity var(--transition);
        }

        #sidebar.collapsed .nav-badge { opacity: 0; }

        /* Tooltip on collapsed */
        #sidebar.collapsed .nav-item-link::after {
            content: attr(data-label);
            position: absolute;
            left: calc(var(--sidebar-collapsed-width) + 8px);
            background: #1f2937;
            color: #f9fafb;
            font-size: 12px;
            font-weight: 500;
            padding: 6px 10px;
            border-radius: 6px;
            white-space: nowrap;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.15s;
            z-index: 9999;
        }

        #sidebar.collapsed .nav-item-link:hover::after { opacity: 1; }

        /* Sidebar Footer */
        .sidebar-footer {
            padding: 16px 20px;
            border-top: 1px solid var(--sidebar-border);
            flex-shrink: 0;
        }

        .sidebar-user {
            display: flex;
            align-items: center;
            gap: 10px;
            overflow: hidden;
        }

        .user-avatar {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 13px;
            font-weight: 700;
            flex-shrink: 0;
        }

        .user-info { overflow: hidden; transition: opacity var(--transition); }
        #sidebar.collapsed .user-info { opacity: 0; }

        .user-name {
            font-size: 13px;
            font-weight: 600;
            color: #f9fafb;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .user-role {
            font-size: 11px;
            color: var(--sidebar-text);
            white-space: nowrap;
        }

        /* ── Main Wrapper ───────────────────────────────────────── */
        #main-wrapper {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            transition: margin-left var(--transition);
        }

        #main-wrapper.expanded { margin-left: var(--sidebar-collapsed-width); }

        /* ── Topbar ─────────────────────────────────────────────── */
        #topbar {
            position: sticky;
            top: 0;
            height: var(--topbar-height);
            background: var(--topbar-bg);
            border-bottom: 1px solid var(--topbar-border);
            box-shadow: var(--topbar-shadow);
            display: flex;
            align-items: center;
            padding: 0 24px;
            gap: 16px;
            z-index: 999;
        }

        /* Toggle btn */
        .sidebar-toggle {
            width: 36px;
            height: 36px;
            border: none;
            background: transparent;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6b7280;
            font-size: 18px;
            cursor: pointer;
            transition: all var(--transition);
            flex-shrink: 0;
        }

        .sidebar-toggle:hover { background: #f3f4f6; color: #111827; }

        /* Search */
        .topbar-search {
            flex: 1;
            max-width: 380px;
            position: relative;
        }

        .topbar-search input {
            width: 100%;
            height: 38px;
            background: #f9fafb;
            border: 1px solid var(--card-border);
            border-radius: 10px;
            padding: 0 14px 0 38px;
            font-family: var(--font-main);
            font-size: 13.5px;
            color: var(--content-text);
            outline: none;
            transition: all var(--transition);
        }

        .topbar-search input:focus {
            border-color: var(--accent);
            background: #fff;
            box-shadow: 0 0 0 3px rgba(99,102,241,0.1);
        }

        .topbar-search input::placeholder { color: #9ca3af; }

        .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 15px;
            pointer-events: none;
        }

        .search-shortcut {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            font-family: var(--font-mono);
            font-size: 10px;
            color: #9ca3af;
            background: #f3f4f6;
            border: 1px solid #e5e7eb;
            border-radius: 4px;
            padding: 1px 5px;
        }

        /* Topbar right */
        .topbar-right {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .topbar-icon-btn {
            width: 38px;
            height: 38px;
            border: none;
            background: transparent;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6b7280;
            font-size: 18px;
            cursor: pointer;
            position: relative;
            transition: all var(--transition);
        }

        .topbar-icon-btn:hover { background: #f3f4f6; color: #111827; }

        .notif-dot {
            position: absolute;
            top: 7px; right: 7px;
            width: 8px; height: 8px;
            background: #ef4444;
            border-radius: 50%;
            border: 2px solid #fff;
        }

        /* Divider */
        .topbar-divider {
            width: 1px;
            height: 24px;
            background: var(--topbar-border);
            margin: 0 6px;
        }

        /* Profile dropdown */
        .profile-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 4px 10px 4px 4px;
            border: none;
            background: transparent;
            border-radius: 10px;
            cursor: pointer;
            transition: all var(--transition);
        }

        .profile-btn:hover { background: #f3f4f6; }

        .profile-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 12px;
            font-weight: 700;
            flex-shrink: 0;
        }

        .profile-info { text-align: left; }

        .profile-name {
            font-size: 13px;
            font-weight: 600;
            color: #111827;
            line-height: 1.2;
        }

        .profile-role {
            font-size: 11px;
            color: #9ca3af;
        }

        .profile-chevron { color: #9ca3af; font-size: 13px; }

        /* Dropdown menu */
        .profile-dropdown {
            min-width: 210px;
            border: 1px solid var(--card-border);
            border-radius: var(--card-radius);
            box-shadow: 0 10px 30px rgba(0,0,0,0.10);
            padding: 6px;
            font-family: var(--font-main);
        }

        .dropdown-header-info {
            padding: 10px 12px 12px;
            border-bottom: 1px solid var(--card-border);
            margin-bottom: 6px;
        }

        .dropdown-user-name {
            font-size: 13.5px;
            font-weight: 600;
            color: #111827;
        }

        .dropdown-user-email {
            font-size: 12px;
            color: #9ca3af;
        }

        .profile-dropdown .dropdown-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 12px;
            font-size: 13.5px;
            color: #374151;
            border-radius: 8px;
            transition: all var(--transition);
        }

        .profile-dropdown .dropdown-item:hover { background: #f3f4f6; color: #111827; }
        .profile-dropdown .dropdown-item i { font-size: 15px; color: #9ca3af; width: 16px; text-align: center; }
        .profile-dropdown .dropdown-item.text-danger { color: #ef4444; }
        .profile-dropdown .dropdown-item.text-danger:hover { background: #fef2f2; }
        .profile-dropdown .dropdown-item.text-danger i { color: #ef4444; }
        .profile-dropdown .dropdown-divider { margin: 6px 0; border-color: var(--card-border); }

        /* Notification dropdown */
        .notif-dropdown {
            min-width: 320px;
            border: 1px solid var(--card-border);
            border-radius: var(--card-radius);
            box-shadow: 0 10px 30px rgba(0,0,0,0.10);
            padding: 0;
            overflow: hidden;
            font-family: var(--font-main);
        }

        .notif-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 16px;
            border-bottom: 1px solid var(--card-border);
        }

        .notif-header span { font-size: 14px; font-weight: 600; color: #111827; }
        .notif-header a { font-size: 12px; color: var(--accent); text-decoration: none; }

        .notif-item {
            display: flex;
            gap: 12px;
            padding: 12px 16px;
            border-bottom: 1px solid #f9fafb;
            transition: background var(--transition);
            cursor: pointer;
        }

        .notif-item:hover { background: #f9fafb; }
        .notif-item.unread { background: rgba(99,102,241,0.04); }

        .notif-icon-wrap {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            flex-shrink: 0;
        }

        .notif-body { flex: 1; }
        .notif-text { font-size: 12.5px; color: #374151; line-height: 1.4; }
        .notif-text strong { color: #111827; }
        .notif-time { font-size: 11px; color: #9ca3af; margin-top: 3px; }

        .notif-footer {
            padding: 10px 16px;
            text-align: center;
        }

        .notif-footer a {
            font-size: 13px;
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
        }

        /* ── Content Area ───────────────────────────────────────── */
        #content {
            flex: 1;
            padding: 28px 28px;
        }

        /* Page header */
        .page-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            margin-bottom: 24px;
        }

        .page-title {
            font-size: 22px;
            font-weight: 700;
            color: #111827;
            letter-spacing: -0.4px;
        }

        .page-breadcrumb {
            font-size: 12.5px;
            color: #9ca3af;
            margin-top: 3px;
        }

        .page-breadcrumb a { color: #6b7280; text-decoration: none; }
        .page-breadcrumb a:hover { color: var(--accent); }

        /* ── Cards ──────────────────────────────────────────────── */
        .card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: var(--card-radius);
            box-shadow: var(--card-shadow);
        }

        /* ── Scrollbar (global) ─────────────────────────────────── */
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #d1d5db; border-radius: 6px; }
        ::-webkit-scrollbar-thumb:hover { background: #9ca3af; }

        /* ── Responsive ─────────────────────────────────────────── */
        @media (max-width: 768px) {
            #sidebar {
                transform: translateX(-100%);
                transition: transform var(--transition), width var(--transition);
            }
            #sidebar.mobile-open { transform: translateX(0); }
            #main-wrapper { margin-left: 0 !important; }
            .topbar-search { max-width: 200px; }
            .search-shortcut { display: none; }
            .profile-info { display: none; }

            .sidebar-overlay {
                display: none;
                position: fixed;
                inset: 0;
                background: rgba(0,0,0,0.5);
                z-index: 999;
            }

            .sidebar-overlay.show { display: block; }
        }
    </style>
</head>
<body>

<!-- Sidebar overlay (mobile) -->
<div class="sidebar-overlay" id="sidebarOverlay" onclick="closeMobileSidebar()"></div>

<!-- ═══════════════════════════════════════════════
     SIDEBAR
════════════════════════════════════════════════ -->
<aside id="sidebar">

    <!-- Brand -->
    <a href="#" class="sidebar-brand">
        <div class="brand-icon">H</div>
        <span class="brand-name">Hyperion</span>
    </a>

    <!-- Navigation -->
    <nav class="sidebar-nav">

        <!-- Main -->
        <div class="nav-section-label">Main</div>

        <a href="#" class="nav-item-link active" data-label="Dashboard">
            <i class="bi bi-grid-1x2-fill nav-icon"></i>
            <span class="nav-label">Dashboard</span>
        </a>

        <a href="#" class="nav-item-link" data-label="Analytics">
            <i class="bi bi-bar-chart-line-fill nav-icon"></i>
            <span class="nav-label">Analytics</span>
        </a>

        <a href="#" class="nav-item-link" data-label="Reports">
            <i class="bi bi-file-earmark-bar-graph nav-icon"></i>
            <span class="nav-label">Reports</span>
        </a>

        <!-- Management -->
        <div class="nav-section-label">Management</div>

        <a href="#" class="nav-item-link" data-label="Users">
            <i class="bi bi-people-fill nav-icon"></i>
            <span class="nav-label">Users</span>
            <span class="nav-badge">24</span>
        </a>

        <a href="#" class="nav-item-link" data-label="Roles">
            <i class="bi bi-shield-lock-fill nav-icon"></i>
            <span class="nav-label">Roles & Permissions</span>
        </a>

        <a href="#" class="nav-item-link" data-label="Modules">
            <i class="bi bi-puzzle-fill nav-icon"></i>
            <span class="nav-label">Modules</span>
        </a>

        <a href="#" class="nav-item-link" data-label="Content">
            <i class="bi bi-layers-fill nav-icon"></i>
            <span class="nav-label">Content</span>
        </a>

        <!-- System -->
        <div class="nav-section-label">System</div>

        <a href="#" class="nav-item-link" data-label="Logs">
            <i class="bi bi-terminal-fill nav-icon"></i>
            <span class="nav-label">Audit Logs</span>
        </a>

        <a href="#" class="nav-item-link" data-label="Settings">
            <i class="bi bi-gear-fill nav-icon"></i>
            <span class="nav-label">Settings</span>
        </a>

    </nav>

    <!-- Footer user -->
    <div class="sidebar-footer">
        <div class="sidebar-user">
            <div class="user-avatar">JD</div>
            <div class="user-info">
                <div class="user-name">Juan Dela Cruz</div>
                <div class="user-role">Super Admin</div>
            </div>
        </div>
    </div>

</aside>

<!-- ═══════════════════════════════════════════════
     MAIN WRAPPER
════════════════════════════════════════════════ -->
<div id="main-wrapper">

    <!-- ── Topbar ────────────────────────────────── -->
    <header id="topbar">

        <!-- Sidebar toggle -->
        <button class="sidebar-toggle" id="sidebarToggle" title="Toggle sidebar">
            <i class="bi bi-list"></i>
        </button>

        <!-- Search -->
        <div class="topbar-search">
            <i class="bi bi-search search-icon"></i>
            <input type="text" placeholder="Search modules, users, reports…">
            <span class="search-shortcut">⌘K</span>
        </div>

        <!-- Right actions -->
        <div class="topbar-right">

            <!-- Notifications -->
            <div class="dropdown">
                <button class="topbar-icon-btn" data-bs-toggle="dropdown" aria-expanded="false" title="Notifications">
                    <i class="bi bi-bell"></i>
                    <span class="notif-dot"></span>
                </button>
                <div class="dropdown-menu dropdown-menu-end notif-dropdown">
                    <div class="notif-header">
                        <span>Notifications</span>
                        <a href="#">Mark all read</a>
                    </div>

                    <div class="notif-item unread">
                        <div class="notif-icon-wrap" style="background:#ede9fe;">
                            <i class="bi bi-person-check-fill" style="color:#7c3aed;"></i>
                        </div>
                        <div class="notif-body">
                            <div class="notif-text"><strong>New user registered</strong> — Maria Santos just created an account.</div>
                            <div class="notif-time">2 minutes ago</div>
                        </div>
                    </div>

                    <div class="notif-item unread">
                        <div class="notif-icon-wrap" style="background:#fef3c7;">
                            <i class="bi bi-exclamation-triangle-fill" style="color:#d97706;"></i>
                        </div>
                        <div class="notif-body">
                            <div class="notif-text"><strong>System alert</strong> — Disk usage exceeded 80% on server-01.</div>
                            <div class="notif-time">15 minutes ago</div>
                        </div>
                    </div>

                    <div class="notif-item">
                        <div class="notif-icon-wrap" style="background:#d1fae5;">
                            <i class="bi bi-check-circle-fill" style="color:#059669;"></i>
                        </div>
                        <div class="notif-body">
                            <div class="notif-text"><strong>Backup completed</strong> — Daily backup finished successfully.</div>
                            <div class="notif-time">1 hour ago</div>
                        </div>
                    </div>

                    <div class="notif-item">
                        <div class="notif-icon-wrap" style="background:#fee2e2;">
                            <i class="bi bi-shield-exclamation" style="color:#dc2626;"></i>
                        </div>
                        <div class="notif-body">
                            <div class="notif-text"><strong>Failed login attempt</strong> — 5 failed attempts on admin account.</div>
                            <div class="notif-time">3 hours ago</div>
                        </div>
                    </div>

                    <div class="notif-footer">
                        <a href="#">View all notifications</a>
                    </div>
                </div>
            </div>

            <!-- Messages -->
            <button class="topbar-icon-btn" title="Messages">
                <i class="bi bi-chat-dots"></i>
            </button>

            <div class="topbar-divider"></div>

            <!-- Profile -->
            <div class="dropdown">
                <button class="profile-btn" data-bs-toggle="dropdown" aria-expanded="false">
                    <div class="profile-avatar">JD</div>
                    <div class="profile-info">
                        <div class="profile-name">Juan Dela Cruz</div>
                        <div class="profile-role">Super Admin</div>
                    </div>
                    <i class="bi bi-chevron-down profile-chevron"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-end profile-dropdown">
                    <div class="dropdown-header-info">
                        <div class="dropdown-user-name">Juan Dela Cruz</div>
                        <div class="dropdown-user-email">juan@hyperion.com</div>
                    </div>
                    <a class="dropdown-item" href="#">
                        <i class="bi bi-person"></i> My Profile
                    </a>
                    <a class="dropdown-item" href="#">
                        <i class="bi bi-gear"></i> Account Settings
                    </a>
                    <a class="dropdown-item" href="#">
                        <i class="bi bi-palette"></i> Appearance
                    </a>
                    <a class="dropdown-item" href="#">
                        <i class="bi bi-bell"></i> Notification Preferences
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item text-danger" href="#">
                        <i class="bi bi-box-arrow-right"></i> Sign Out
                    </a>
                </div>
            </div>

        </div>
    </header>

    <!-- ── Page Content ──────────────────────────── -->
    <main id="content">

        <!-- Page Header -->
        <div class="page-header">
            <div>
                <div class="page-title"><?= $title ?? 'Dashboard' ?></div>
                <div class="page-breadcrumb">
                    <a href="#">Home</a> / <?= $title ?? 'Dashboard' ?>
                </div>
            </div>
        </div>

        <!-- ↓↓ Your view content loads here ↓↓ -->
        <!-- <?php $this->load->view($content_view, $content_data ?? []); ?> -->

    </main>

</div><!-- /main-wrapper -->

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const sidebar      = document.getElementById('sidebar');
    const mainWrapper  = document.getElementById('main-wrapper');
    const toggleBtn    = document.getElementById('sidebarToggle');
    const overlay      = document.getElementById('sidebarOverlay');
    const isMobile     = () => window.innerWidth <= 768;

    // Desktop — collapse/expand
    toggleBtn.addEventListener('click', () => {
        if (isMobile()) {
            sidebar.classList.toggle('mobile-open');
            overlay.classList.toggle('show');
        } else {
            sidebar.classList.toggle('collapsed');
            mainWrapper.classList.toggle('expanded');
        }
    });

    function closeMobileSidebar() {
        sidebar.classList.remove('mobile-open');
        overlay.classList.remove('show');
    }

    // Active nav link
    document.querySelectorAll('.nav-item-link').forEach(link => {
        link.addEventListener('click', function() {
            document.querySelectorAll('.nav-item-link').forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // Search shortcut ⌘K / Ctrl+K
    document.addEventListener('keydown', e => {
        if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
            e.preventDefault();
            document.querySelector('.topbar-search input').focus();
        }
    });
</script>

</body>
</html>
