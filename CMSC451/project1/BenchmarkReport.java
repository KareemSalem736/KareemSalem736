/*
Kareem Salem    CMSC451     Project 1   06/05/2025 
 */

import javax.swing.*;
import javax.swing.table.AbstractTableModel;
import java.awt.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BenchmarkReport {

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new BenchmarkReport().run();
        });
    }

    public void run() {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setDialogTitle("Select Benchmark File");
        fileChooser.setCurrentDirectory(new File(System.getProperty("user.dir")));
        fileChooser.setFileFilter(new javax.swing.filechooser.FileFilter() {
            @Override
            public boolean accept(File f) {
                return f.isDirectory() ||
                    f.getName().equals("quickSort.txt") ||
                    f.getName().equals("bubbleSort.txt");
            }

            @Override
            public String getDescription() {
                return "Benchmark Files (quickSort.txt, bubbleSort.txt)";
            }
        });

        int result = fileChooser.showOpenDialog(null);


        if (result == JFileChooser.APPROVE_OPTION) {
            File selectedFile = fileChooser.getSelectedFile();

            List<Object[]> tableData = new ArrayList<>();

            try (BufferedReader reader = new BufferedReader(new FileReader(selectedFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] tokens = line.trim().split("\\s+");
                    int size = Integer.parseInt(tokens[0]);

                    List<Integer> counts = new ArrayList<>();
                    List<Long> times = new ArrayList<>();

                    for (int i = 1; i < tokens.length; i += 2) {
                        counts.add(Integer.parseInt(tokens[i]));
                        times.add(Long.parseLong(tokens[i + 1]));
                    }

                    double avgCount = average(counts);
                    double covCount = coefficientOfVariation(counts, avgCount);

                    double avgTime = average(times);
                    double covTime = coefficientOfVariation(times, avgTime);

                    Object[] row = {
                        size,
                        String.format("%.2f", avgCount),
                        String.format("%.2f", covCount) + "%",
                        String.format("%.2f", avgTime),
                        String.format("%.2f", covTime) + "%"
                    };

                    tableData.add(row);
                }

                String[] columnNames = {
                    "Data Set Size", "Avg Count", "CoV Count (%)", "Avg Time (ns)", "CoV Time (%)"
                };

                JTable table = new JTable(new ReportTableModel(tableData, columnNames));
                JScrollPane scrollPane = new JScrollPane(table);

                JFrame frame = new JFrame("Benchmark Report - " + selectedFile.getName());
                frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                frame.add(scrollPane, BorderLayout.CENTER);
                frame.setSize(600, 400);
                frame.setVisible(true);

            } catch (IOException | NumberFormatException e) {
                JOptionPane.showMessageDialog(null, "Error reading or parsing file: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    private double average(List<? extends Number> values) {
        return values.stream().mapToDouble(Number::doubleValue).average().orElse(0.0);
    }

    private double coefficientOfVariation(List<? extends Number> values, double mean) {
        if (mean == 0.0) return 0.0;

        double variance = values.stream()
            .mapToDouble(v -> Math.pow(v.doubleValue() - mean, 2))
            .sum() / values.size();

        double stdDev = Math.sqrt(variance);
        return (stdDev / mean) * 100;
    }

    static class ReportTableModel extends AbstractTableModel {
        private final List<Object[]> data;
        private final String[] columnNames;

        public ReportTableModel(List<Object[]> data, String[] columnNames) {
            this.data = data;
            this.columnNames = columnNames;
        }

        @Override
        public int getRowCount() {
            return data.size();
        }

        @Override
        public int getColumnCount() {
            return columnNames.length;
        }

        @Override
        public Object getValueAt(int rowIndex, int columnIndex) {
            return data.get(rowIndex)[columnIndex];
        }

        @Override
        public String getColumnName(int column) {
            return columnNames[column];
        }
    }
}
