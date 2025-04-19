const { db } = require('../config');

// Get all reports
exports.getReports = async (req, res) => {
  try {
    const [results] = await db.query('SELECT * FROM reports');
    res.status(200).json(results);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Create report
exports.createReport = async (req, res) => {
  const { id_project, created_by, report_type, report_parameters, report_data, expiresAt } = req.body;

  if (!id_project || !created_by || !report_type || !report_parameters || !report_data || !expiresAt || isNaN(Date.parse(expiresAt))) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  try {
    const [projectCheck] = await db.query('SELECT id FROM projects WHERE id = ?', [id_project]);

    if (projectCheck.length === 0) {
      return res.status(400).json({ message: 'Invalid id_project. Project does not exist.' });
    }

    const expiresAtFormatted = new Date(expiresAt).toISOString().slice(0, 19).replace('T', ' ');

    const [result] = await db.query(
      'INSERT INTO reports (id_project, created_by, report_type, report_parameters, report_data, generatedAt, expiresAt) VALUES (?, ?, ?, ?, ?, NOW(), ?)',
      [id_project, created_by, report_type, report_parameters, report_data, expiresAtFormatted]
    );

    res.status(201).json({ message: 'Report created', id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Update report
exports.updateReport = async (req, res) => {
  const { id } = req.params;
  const { id_project, created_by, report_type, report_parameters, report_data, expiresAt } = req.body;

  if (!created_by || !report_type || !report_parameters || !report_data || !expiresAt || isNaN(Date.parse(expiresAt))) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  const expiresAtFormatted = new Date(expiresAt).toISOString().slice(0, 19).replace('T', ' ');

  try {
    // If id_project is provided, include it in the update
    if (id_project) {
      await db.query(
        'UPDATE reports SET id_project = ?, created_by = ?, report_type = ?, report_parameters = ?, report_data = ?, expiresAt = ? WHERE id = ?',
        [id_project, created_by, report_type, report_parameters, report_data, expiresAtFormatted, id]
      );
    } else {
      await db.query(
        'UPDATE reports SET created_by = ?, report_type = ?, report_parameters = ?, report_data = ?, expiresAt = ? WHERE id = ?',
        [created_by, report_type, report_parameters, report_data, expiresAtFormatted, id]
      );
    }

    res.status(200).json({ message: 'Report updated' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Delete report
exports.deleteReport = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query('DELETE FROM reports WHERE id = ?', [id]);
    res.status(200).json({ message: 'Report deleted' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};