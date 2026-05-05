document.addEventListener('DOMContentLoaded', () => {
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

    const syncToggleState = (isOpen) => {
        sidebar.classList.toggle('open', isOpen);
        document.body.classList.toggle('sidebar-open', isOpen);
        overlay.classList.toggle('is-active', isOpen);

        toggles.forEach((toggle) => {
            toggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
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
