const MPTedTheme = (() => {
    const storageKey = 'theme';
    const mediaQuery = window.matchMedia ? window.matchMedia('(prefers-color-scheme: dark)') : null;

    function getStoredTheme() {
        try {
            const value = localStorage.getItem(storageKey);
            return value === 'dark' || value === 'light' ? value : null;
        } catch (error) {
            return null;
        }
    }

    function getSystemTheme() {
        return mediaQuery && mediaQuery.matches ? 'dark' : 'light';
    }

    function getResolvedTheme() {
        return getStoredTheme() || getSystemTheme();
    }

    function applyTheme(theme) {
        const resolvedTheme = theme === 'dark' ? 'dark' : 'light';
        const isDark = resolvedTheme === 'dark';

        document.documentElement.classList.toggle('dark-theme', isDark);
        document.documentElement.setAttribute('data-theme', resolvedTheme);

        if (document.body) {
            document.body.classList.toggle('dark-theme', isDark);
            document.body.setAttribute('data-theme', resolvedTheme);
        }

        window.dispatchEvent(new CustomEvent('mpted:themechange', {
            detail: { theme: resolvedTheme }
        }));

        return resolvedTheme;
    }

    function setTheme(theme, options = {}) {
        const persist = options.persist !== false;
        const resolvedTheme = theme === 'dark' ? 'dark' : 'light';

        if (persist) {
            try {
                localStorage.setItem(storageKey, resolvedTheme);
            } catch (error) {
            }
        }

        return applyTheme(resolvedTheme);
    }

    function syncTheme() {
        return applyTheme(getResolvedTheme());
    }

    function toggleTheme() {
        return setTheme(getResolvedTheme() === 'dark' ? 'light' : 'dark');
    }

    if (mediaQuery) {
        mediaQuery.addEventListener('change', () => {
            if (!getStoredTheme()) {
                syncTheme();
            }
        });
    }

    return {
        get: getResolvedTheme,
        set: setTheme,
        toggle: toggleTheme,
        sync: syncTheme
    };
})();

window.MPTedTheme = MPTedTheme;

document.addEventListener('DOMContentLoaded', () => {
    MPTedTheme.sync();
    initRevealAnimations();
    initSidebarToggle();
});

function initRevealAnimations() {
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
        return;
    }

    const selectors = [
        '.page-header',
        '.card',
        '.stat',
        '.day',
        '.subject-card',
        '.overall-card',
        '.announcement-card',
        '.grade-item',
        '.homework-item',
        '.schedule-today',
        '.announcements-container',
        '.grades-container',
        '.homework-container',
        '.table-container',
        '.table-responsive',
        '.stat-card-compact',
        '.no-data-card'
    ];

    const nodes = [];
    const seen = new Set();

    selectors.forEach((selector) => {
        document.querySelectorAll(selector).forEach((node) => {
            if (seen.has(node)) {
                return;
            }

            seen.add(node);
            nodes.push(node);
        });
    });

    if (!nodes.length) {
        return;
    }

    nodes.forEach((node, index) => {
        node.setAttribute('data-reveal', '');
        node.style.setProperty('--reveal-order', String(index % 12));
    });

    if (!('IntersectionObserver' in window)) {
        nodes.forEach((node) => node.classList.add('is-visible'));
        return;
    }

    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (!entry.isIntersecting) {
                return;
            }

            entry.target.classList.add('is-visible');
            observer.unobserve(entry.target);
        });
    }, {
        rootMargin: '0px 0px -10% 0px',
        threshold: 0.12
    });

    nodes.forEach((node) => observer.observe(node));
}

function initSidebarToggle() {
    const sidebar = document.querySelector('[data-sidebar]');
    const toggles = Array.from(document.querySelectorAll('[data-mobile-sidebar-toggle]'));

    if (!sidebar || !toggles.length) {
        return;
    }

    document.body.classList.add('has-sidebar-layout');

    let overlay = document.querySelector('.sidebar-overlay');
    if (!overlay) {
        overlay = document.createElement('button');
        overlay.type = 'button';
        overlay.className = 'sidebar-overlay';
        overlay.setAttribute('aria-label', 'Закрыть боковое меню');
        document.body.appendChild(overlay);
    }

    const iconSelector = 'i';
    const desktopQuery = window.matchMedia('(min-width: 1025px)');
    const updateOverlayOffset = () => {
        const sidebarWidth = Math.ceil(sidebar.getBoundingClientRect().width);
        overlay.style.setProperty('--sidebar-overlay-offset', `${sidebarWidth}px`);
    };

    const syncToggleState = (isOpen) => {
        updateOverlayOffset();
        sidebar.classList.toggle('open', isOpen);
        document.body.classList.toggle('sidebar-open', isOpen);
        overlay.classList.toggle('is-active', isOpen);

        toggles.forEach((toggle) => {
            toggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
            toggle.classList.toggle('active', isOpen);
            const icon = toggle.querySelector(iconSelector);
            if (icon) {
                icon.className = isOpen ? 'bi bi-x-lg' : 'bi bi-list';
            }
        });
    };

    const closeSidebar = () => syncToggleState(false);
    const toggleSidebar = () => syncToggleState(!sidebar.classList.contains('open'));

    toggles.forEach((toggle) => {
        toggle.addEventListener('click', (event) => {
            event.preventDefault();
            event.stopPropagation();
            toggleSidebar();
        });
    });

    overlay.addEventListener('click', closeSidebar);
    window.addEventListener('resize', updateOverlayOffset);
    updateOverlayOffset();

    sidebar.querySelectorAll('a').forEach((link) => {
        link.addEventListener('click', closeSidebar);
    });

    document.addEventListener('keydown', (event) => {
        if (event.key === 'Escape') {
            closeSidebar();
        }
    });

    desktopQuery.addEventListener('change', (event) => {
        if (event.matches) {
            closeSidebar();
        }
    });
}
