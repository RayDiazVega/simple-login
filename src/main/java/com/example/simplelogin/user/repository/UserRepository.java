package com.example.simplelogin.user.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Repository
public class UserRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> findUsers() {
        return jdbcTemplate.queryForList("SELECT * FROM USERS");
    }

    public void transferencia(Connection conn, BigDecimal importe, int cliente1, int cliente2) throws SQLException {

        conn.setAutoCommit(false);

        try {
            PreparedStatement statement = conn.prepareStatement("SELECT saldo FROM clientes WHERE cliente = ?");
            statement.setInt(1, cliente1);
            ResultSet resultSet = statement.executeQuery();

            if (!resultSet.next()) {
                throw new SQLException("No se encontró informacion del cliente" + cliente1);
            }

            BigDecimal saldoCliente1 = resultSet.getBigDecimal(1);

            statement = conn.prepareStatement("SELECT saldo FROM clientes WHERE cliente = ?");
            statement.setInt(1, cliente2);
            resultSet = statement.executeQuery();

            if (!resultSet.next()) {
                throw new SQLException("No se encontró informacion del cliente" + cliente2);
            }

            BigDecimal saldoCliente2 = resultSet.getBigDecimal(1);

            saldoCliente1 = saldoCliente1.subtract(importe);

            saldoCliente2 = saldoCliente2.add(importe);

            statement = conn.prepareStatement("UPDATE clientes SET saldo = ? WHERE cliente = ?");
            statement.setBigDecimal(1, saldoCliente1);
            statement.setInt(2, cliente1);
            statement.executeUpdate();

            statement = conn.prepareStatement("UPDATE clientes SET saldo = ? WHERE cliente = ?");
            statement.setBigDecimal(1, saldoCliente2);
            statement.setInt(2, cliente2);
            statement.executeUpdate();

            conn.commit();
        } catch (SQLException ex) {
            conn.rollback();
            throw ex;
        } finally {
            conn.setAutoCommit(true);
        }
    }
}
