package com.krakedev.servicios;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.krakedev.entidades.Cliente;
import com.krakedev.excepciones.KrakeDevException;
import com.krakedev.persistencia.ClientesBDD;

@Path("customers")
public class ServicioClientes {

	@Path("m1")
	@GET
	public String saludar() {
		return "Hola mundo Rest Web Services";
	}

	@Path("mbuscar")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Cliente buscar() {
		Cliente cliente = new Cliente("0302578166", "Jose");

		return cliente;
	}
	
	@Path("insertar")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	public Response insertar(Cliente cliente) {
		System.out.println(">>>>>>>>"+cliente);
		ClientesBDD cli = new ClientesBDD();
		try {
			cli.insertar(cliente);
			return Response.ok().build();
		} catch (KrakeDevException e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
	
	/*@Path("act")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	public void actualizar(Cliente cliente) {
		System.out.println("ACTUALIZANDO CLIENTE>>>>>>>>>> "+cliente);
	}*/
	@Path("act")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	public Response actualizar(Cliente cliente) {
		System.out.println("ACTUALIZANDO >>>>>>>>>> "+cliente);
		ClientesBDD cli = new ClientesBDD();
		try {
			cli.actualizar(cliente);
			return Response.ok().build();
		} catch (KrakeDevException e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
	
	@Path("all")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response obtenerClientes(){
		ClientesBDD cli = new ClientesBDD();
		ArrayList<Cliente> clientes = null;
		try {
			clientes = cli.recuperarTodos();
			return Response.ok(clientes).build();
		} catch (KrakeDevException e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
	
	@Path("buscarPorCedula/{cedulaParam}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response buscarPorCedula(@PathParam("cedulaParam") String cedula){
		ClientesBDD cli = new ClientesBDD();
		Cliente cliente = null;
		System.out.println("INGRESA>>>>>>> "+cedula);
		try {
			cliente = cli.buscarPorPK(cedula);
			return Response.ok(cliente).build();
		} catch (KrakeDevException e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
	
	@Path("buscarPorNH/{numeroHijosParam}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response buscarPorNH(@PathParam("numeroHijosParam") int numeroDeHijos){
		ClientesBDD cli = new ClientesBDD();
		List<Cliente> cliente = null;
		System.out.println("INGRESA>>>>>>> "+numeroDeHijos);
		try {
			cliente = cli.buscarPorNH(numeroDeHijos);
			return Response.ok(cliente).build();
		} catch (KrakeDevException e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
}
