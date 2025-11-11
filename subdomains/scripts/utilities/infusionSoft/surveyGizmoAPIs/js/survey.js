<script>
// Pagination and Search functionality
let currentPage = 1;
let rowsPerPage = 10;
let allRows = [];
let filteredRows = [];
let sortColumn = '';
let sortDirection = 'asc';

document.addEventListener('DOMContentLoaded', function () {
  const table = document.getElementById('surveyTable');
  if (!table) return;

  const tbody = table.querySelector('tbody');
  allRows = Array.from(tbody.querySelectorAll('tr')).filter(
    (row) => !row.classList.contains('total-row')
  );
  filteredRows = [...allRows];

  setupSearch();
  setupSorting();
  setupPagination();
  updateDisplay();
  updateStats();
});

function setupSearch() {
  const searchInput = document.getElementById('searchInput');
  if (searchInput) {
    searchInput.addEventListener('input', function () {
      const searchTerm = this.value.toLowerCase();
      filteredRows = allRows.filter((row) => {
        const text = row.textContent.toLowerCase();
        return text.includes(searchTerm);
      });
      currentPage = 1;
      updateDisplay();
    });
  }
}

function setupSorting() {
  const headers = document.querySelectorAll('.sortable');
  headers.forEach((header, index) => {
    header.addEventListener('click', function () {
      const column = index;

      if (sortColumn === column) {
        sortDirection = sortDirection === 'asc' ? 'desc' : 'asc';
      } else {
        sortColumn = column;
        sortDirection = 'asc';
      }

      // Update header classes
      headers.forEach((h) => h.classList.remove('sort-asc', 'sort-desc'));
      this.classList.add(sortDirection === 'asc' ? 'sort-asc' : 'sort-desc');

      sortRows(column, sortDirection);
      updateDisplay();
    });
  });
}

function sortRows(column, direction) {
  filteredRows.sort((a, b) => {
    let aVal = a.cells[column].textContent.trim();
    let bVal = b.cells[column].textContent.trim();

    // Handle dates
    if (column === 1) {
      aVal = new Date(aVal) || new Date('1900-01-01');
      bVal = new Date(bVal) || new Date('1900-01-01');
    }
    // Handle hours
    else if (column === 2) {
      aVal = parseFloat(aVal.replace(/[^\d.-]/g, '')) || 0;
      bVal = parseFloat(bVal.replace(/[^\d.-]/g, '')) || 0;
    }

    if (aVal < bVal) return direction === 'asc' ? -1 : 1;
    if (aVal > bVal) return direction === 'asc' ? 1 : -1;
    return 0;
  });
}

function setupPagination() {
  const pageSizeSelect = document.getElementById('pageSize');
  if (pageSizeSelect) {
    pageSizeSelect.addEventListener('change', function () {
      rowsPerPage = parseInt(this.value);
      currentPage = 1;
      updateDisplay();
    });
  }
}

function updateDisplay() {
  const tbody = document.querySelector('#surveyTable tbody');
  const totalRows = filteredRows.length;
  const totalPages = Math.ceil(totalRows / rowsPerPage);

  // Clear tbody except total row
  const totalRow = tbody.querySelector('.total-row');
  tbody.innerHTML = '';

  // Add filtered and paginated rows
  const start = (currentPage - 1) * rowsPerPage;
  const end = start + rowsPerPage;
  const pageRows = filteredRows.slice(start, end);

  pageRows.forEach((row) => {
    tbody.appendChild(row.cloneNode(true));
  });

  // Add total row back
  if (totalRow) {
    tbody.appendChild(totalRow);
  }

  // Update pagination display
  updatePaginationControls(totalPages, totalRows);
}

function updatePaginationControls(totalPages, totalRows) {
  const pageInfo = document.getElementById('pageInfo');
  const prevBtn = document.getElementById('prevPage');
  const nextBtn = document.getElementById('nextPage');
  const firstBtn = document.getElementById('firstPage');
  const lastBtn = document.getElementById('lastPage');

  if (pageInfo) {
    const start = Math.min((currentPage - 1) * rowsPerPage + 1, totalRows);
    const end = Math.min(currentPage * rowsPerPage, totalRows);
    pageInfo.textContent = `Showing ${start}-${end} of ${totalRows} records`;
  }

  if (prevBtn) prevBtn.disabled = currentPage === 1;
  if (nextBtn)
    nextBtn.disabled = currentPage === totalPages || totalPages === 0;
  if (firstBtn) firstBtn.disabled = currentPage === 1;
  if (lastBtn)
    lastBtn.disabled = currentPage === totalPages || totalPages === 0;
}

function changePage(direction) {
  const totalPages = Math.ceil(filteredRows.length / rowsPerPage);

  switch (direction) {
    case 'first':
      currentPage = 1;
      break;
    case 'prev':
      if (currentPage > 1) currentPage--;
      break;
    case 'next':
      if (currentPage < totalPages) currentPage++;
      break;
    case 'last':
      currentPage = totalPages;
      break;
  }

  updateDisplay();
}

// Update dashboard stats
function updateStats() {
  const totalRecords = allRows.length;
  const totalHoursElement = document.querySelector('.total-row td');
  const totalHours = totalHoursElement
    ? totalHoursElement.textContent.match(/[\d.]+/)?.[0] || '0'
    : '0';

  // Update dashboard if elements exist
  const totalRecordsEl = document.getElementById('totalRecords');
  const totalHoursEl = document.getElementById('totalHours');
  const completedCoursesEl = document.getElementById('completedCourses');

  if (totalRecordsEl) totalRecordsEl.textContent = totalRecords;
  if (totalHoursEl) totalHoursEl.textContent = totalHours;
  if (completedCoursesEl) completedCoursesEl.textContent = totalRecords;
}
</script>