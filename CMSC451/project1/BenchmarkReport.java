import javax.swing.JFileChooser;
import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableModel;
import javax.swing.JScrollPane;

import java.io.BufferedReader;
import java.io.FileReader;

public class BenchmarkReport {
    public void benchmarkRport(String file) {
        TableModel dataModel = new AbstractTableModel() {
            public int getColumnCount() { return 12; }
            public int getRowCount() { return 4; }
            public Object getValueAt(int row, int col) { return new Integer(row*col); }
        };
        JTable table = new JTable(dataModel);
        JScrollPane scrollpane = new JScrollPane(table);

        int[] selectionRow = table.getSelectedRows();
        for (int i = 0; i < selectionRow.length; i++) {
            selectionRow[i] = table.convertRowIndexToModel(selectionRow[i]);
        }
        int[] selectionCol = table.getSelectedColumns();
        for (int i = 0; i < selectionCol.length; i++) {
            selectionCol[i] = table.convertColumnIndexToModel(selectionCol[i]);
        }
    }
}