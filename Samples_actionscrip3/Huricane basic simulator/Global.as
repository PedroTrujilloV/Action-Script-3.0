package
{

	public dynamic class Global 
	{

		private static var global : Global;

		public static function getInstance():Global 
		{

			if ( global == null ) 
			{

				global = new Global( arguments.callee );

			}

			return global;

		}

		public function Global( caller : Function = null ) 
		{

			if ( caller != Global.getInstance ) 
			{

				throw new Error("Global is a singleton class, use getInstance() instead");

			}

			if ( Global.global != null ) 
			{

				throw new Error("Only one Global instance should be instantiated");

			}

		}

	}

}
