package com.krakedev.inventarios.bdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.krakedev.inventarios.entidades.Proveedor;
import com.krakedev.inventarios.entidades.TipoDocumento;
import com.krakedev.inventarios.excepciones.KrakeDevException;
import com.krakedev.inventarios.utils.ConexionBDD;

public class ProveedoresBDD {
	public ArrayList<Proveedor> buscar(String subcadena) throws KrakeDevException {
		ArrayList<Proveedor> proveedores = new ArrayList<Proveedor>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Proveedor proveedor = null;
		try {
			con = ConexionBDD.obtenerConexion();
			ps = con.prepareStatement("select prov.identificador, prov.tipo_de_documento, td.descripcion, prov.nombre, prov.telefono, prov.correo, prov.direccion "
					+ "from proveedores prov, tipo_de_documentos td "
					+ "where prov.tipo_de_documento = td.codigo "
					+ "and upper(nombre) like ?");
			ps.setString(1, "%"+subcadena.toUpperCase()+"%");
			rs = ps.executeQuery();

			while (rs.next()) {
				String identificador = rs.getString("identificador");
				String codigoTipoDeDocumento = rs.getString("tipo_de_documento");
				String descripcionTipoDocumento = rs.getString("descripcion");
				String nombre = rs.getString("nombre");
				String telefono = rs.getString("telefono");
				String correo = rs.getString("correo");
				String direccion = rs.getString("direccion");
				TipoDocumento td = new TipoDocumento(codigoTipoDeDocumento, descripcionTipoDocumento);
				
				proveedor = new Proveedor(identificador, td, nombre, telefono, correo, direccion);
				proveedores.add(proveedor);
			}
		} catch (KrakeDevException e) {
			e.printStackTrace();
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new KrakeDevException("Error al consultar. Detalle: " + e.getMessage());
		}
		return proveedores;
	}
	
	public ArrayList<TipoDocumento> recuparar() throws KrakeDevException {
		ArrayList<TipoDocumento> documentos = new ArrayList<TipoDocumento>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TipoDocumento documento = null;
		try {
			con = ConexionBDD.obtenerConexion();
			ps = con.prepareStatement("select codigo, descripcion from tipo_de_documentos");
			rs = ps.executeQuery();

			while (rs.next()) {
				String codigo = rs.getString("codigo");
				String descripcion = rs.getString("descripcion");
				
				documento = new TipoDocumento(codigo, descripcion);
				documentos.add(documento);
			}
		} catch (KrakeDevException e) {
			e.printStackTrace();
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new KrakeDevException("Error al consultar. Detalle: " + e.getMessage());
		}
		return documentos;
	}
}
