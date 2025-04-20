document.addEventListener("DOMContentLoaded", () => {
  const toggleButton = document.getElementById("toggleSidebar")
  const sidebar = document.getElementById("sidebar")

  toggleButton.addEventListener("click", () => {
    sidebar.classList.toggle("collapsed")
  })

  document.querySelectorAll(".project-item").forEach(item => {
    item.addEventListener("click", () => {
      document.querySelectorAll(".project-item").forEach(i => i.classList.remove("active"))
      item.classList.add("active")
      loadProjectData(item.innerText.trim())
    })
  })

  document.getElementById("filterLanguage").addEventListener("change", () => {
    const selected = document.getElementById("filterLanguage").value
    const sentimentFilter = document.getElementById("filterSentiment")
    sentimentFilter.disabled = selected === "other"
    if (sentimentFilter.disabled) sentimentFilter.value = ""

    const project = document.querySelector(".project-item.active")?.innerText?.trim()
    if (project) loadProjectData(project)
  })

  document.getElementById("filterSentiment").addEventListener("change", () => {
    const project = document.querySelector(".project-item.active")?.innerText?.trim()
    if (project) loadProjectData(project)
  })

  document.getElementById("monthPicker").addEventListener("change", () => {
    const project = document.querySelector(".project-item.active")?.innerText?.trim()
    if (project) loadProjectData(project)
  })

  document.querySelectorAll(".filter-source").forEach(cb => {
    cb.addEventListener("change", () => {
      const project = document.querySelector(".project-item.active")?.innerText?.trim()
      if (project) loadProjectData(project)
    })
  })

  document.getElementById("searchForm").addEventListener("submit", e => {
    e.preventDefault()
    const project = document.querySelector(".project-item.active")?.innerText?.trim()
    if (project) loadProjectData(project)
  })

  loadAllProjects()
})

// Fungsi utama ambil data project
async function loadProjectData(projectName) {
  try {
    const language = document.getElementById("filterLanguage")?.value || ""
    const sentiment = document.getElementById("filterSentiment")?.value || ""
    const sources = [...document.querySelectorAll(".filter-source:checked")].map(el => el.value)
    let keywordSearch = document.getElementById("searchKeyword")?.value || ""

    if (!keywordSearch) {
      try {
        const resProject = await fetch(`http://localhost:3000/search?project_name=${encodeURIComponent(projectName)}`)
        const data = await resProject.json()
        if (data.project?.keyword) {
          keywordSearch = data.project.keyword
          document.getElementById("searchKeyword").value = keywordSearch 
        }
      } catch (err) {
        console.error("Gagal ambil keyword project:", err)
      }
    }


    const monthPickerValue = document.getElementById("monthPicker")?.value || ""
    let year = "", month = ""
    if (monthPickerValue) {
      [year, month] = monthPickerValue.split("-")
    }

    const params = new URLSearchParams({ project_name: projectName })
    if (language) params.append("language", language)
    if (sentiment) params.append("sentiment", sentiment)
    if (year) params.append("year", year)
    if (month) params.append("month", month)
    sources.forEach(src => params.append("source", src))
    if (keywordSearch) params.append("search", keywordSearch)

    const summaryParams = new URLSearchParams(params)
    const resSummary = await fetch(`http://localhost:3000/search/summary/platform?${summaryParams.toString()}`)
    const summary = (await resSummary.json()).data || []

    const countMap = Object.fromEntries(summary.map(s => [s.source_name.toLowerCase(), s.total_mentions]))
    document.getElementById("twitter-count").innerText = countMap["twitter"] || 0
    document.getElementById("youtube-count").innerText = countMap["youtube"] || 0
    document.getElementById("google-count").innerText = countMap["google news"] || 0
    document.getElementById("total-count").innerText = summary.reduce((sum, d) => sum + Number(d.total_mentions), 0)

    const resMentions = await fetch(`http://localhost:3000/search/mentions?${params.toString()}`)
    const mentions = (await resMentions.json()).data || []

    renderMonitoringResults(mentions)
  } catch (err) {
    console.error("Gagal ambil data project:", err)
    alert("Gagal memuat data project.")
  }
}

function renderMonitoringResults(data) {
  const container = document.getElementById("monitoring-results")
  container.innerHTML = ""

  const keyword = document.getElementById("searchKeyword")?.value?.toLowerCase() || ""

  data.forEach(item => {
    const sourceIcon = getMediaIcon(item.source_name)
    const profile = item.profile_image || 0

    const dateObj = new Date(item.date)
    const jam = dateObj.getHours().toString().padStart(2, '0')
    const menit = dateObj.getMinutes().toString().padStart(2, '0')
    const tanggal = dateObj.toLocaleDateString("id-ID", { day: "2-digit", month: "short", year: "numeric" })

    const dateFormatted = `${tanggal} WIB ${jam}.${menit}`


    let highlightedContent = item.content
    if (keyword) {
      const regex = new RegExp(`(${keyword})`, "gi")
      highlightedContent = item.content.replace(regex, "<b>$1</b>")
    }

    const el = document.createElement("div")
    el.className = "col-12"
    el.innerHTML = `
      <div class="media-card position-relative">    
        <div class="d-flex align-items-start gap-3">
          <img src="${sourceIcon}" alt="media" width="24" height="24" />
          <div class="d-flex flex-column flex-grow-1">
            <div class="d-flex align-items-center gap-2 mb-1">
              <img src="${profile}" width="28" height="28" style="border-radius: 50%;" alt="profile" />
              <div>
                <div class="fw-semibold">${item.author || 'Anonim'}</div>
                <div class="text-muted small">${dateFormatted}</div>
              </div>
            </div>
            <p class="mb-1">${highlightedContent}</p>
            <a href="${item.url}" target="_blank" class="small text-primary">Lihat selengkapnya</a>
          </div>
          ${item.sentiment_category ? `
            <span class="badge badge-sentiment text-capitalize" style="background-color: ${getPastelColor(item.sentiment_category)}">
              ${item.sentiment_category}
            </span>
          ` : ''}
        </div>
      </div>
    `
    container.appendChild(el)
  })
}

function getMediaIcon(source) {
  const s = source.toLowerCase()
  if (s.includes("twitter")) return "https://cdn-icons-png.flaticon.com/512/733/733579.png"
  if (s.includes("youtube")) return "https://cdn-icons-png.flaticon.com/512/1384/1384060.png"
  if (s.includes("google")) return "https://cdn-icons-png.flaticon.com/512/300/300221.png"
  return "https://cdn-icons-png.flaticon.com/512/565/565547.png"
}

function getPastelColor(sentiment) {
  switch (sentiment?.toLowerCase()) {
    case "positive": return "#86efac"
    case "negative": return "#fca5a5"
    case "neutral": return "#cbd5e1"
    default: return "#f1f5f9"
  }
}

async function loadAllProjects() {
  try {
    const res = await fetch("http://localhost:3000/search")
    const data = await res.json()
    const projects = data.projects || []

    const projectList = document.getElementById("projectList")
    projectList.innerHTML = ""

    projects.forEach(project => {
      const div = document.createElement("div")
      div.className = "project-item"
      div.innerText = project.project_name

      div.addEventListener("click", () => {
        document.querySelectorAll(".project-item").forEach(i => i.classList.remove("active"))
        div.classList.add("active")
        document.getElementById("searchKeyword").value = ""
        loadProjectData(project.project_name)
        localStorage.setItem("lastProject", project.project_name)
      })
      

      projectList.appendChild(div)
    })

    const lastProject = localStorage.getItem("lastProject")
    if (lastProject) {
      const active = [...document.querySelectorAll(".project-item")].find(i => i.innerText.trim() === lastProject)
      if (active) active.classList.add("active")
      loadProjectData(lastProject)
    }
  } catch (err) {
    console.error("Gagal ambil semua project:", err)
  }
}

document.getElementById("exportPdfBtn").addEventListener("click", (e) => {
  e.preventDefault()

  const project = document.querySelector(".project-item.active")?.innerText?.trim() || "project"
  const dateStr = new Date().toISOString().split("T")[0]

  const pdfElement = document.createElement("div")
  pdfElement.innerHTML = `
    <h3>Laporan Media Monitoring</h3>
    <p><strong>Project:</strong> ${project}</p>
    <p><strong>Tanggal:</strong> ${dateStr}</p>
    <div>${document.getElementById("monitoring-results").innerHTML}</div>
  `

  const opt = {
    margin: 0.5,
    filename: `report-${project}-${dateStr}.pdf`,
    image: { type: 'jpeg', quality: 0.98 },
    html2canvas: { scale: 2 },
    jsPDF: { unit: 'in', format: 'a4', orientation: 'portrait' }
  }

  html2pdf().set(opt).from(pdfElement).save()
})
